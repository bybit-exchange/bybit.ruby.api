# frozen_string_literal: true

require 'faraday'
require 'json'
require 'timeout'
require 'uri'

module Bybit
  # Session owns the Faraday connection + auth-header assembly. Every service
  # class receives a Session instance and dispatches through public_request /
  # sign_request. Modeled after binance-connector-ruby's Session pattern.
  #
  # Signing invariant: the payload signed and the query string sent on the
  # wire MUST be byte-identical. We enforce this by building ONE query_str
  # (via encode_query after key-sort) and using it verbatim for both
  # the signature payload AND the request URL — never letting Faraday's
  # NestedParamsEncoder re-serialize the params. This avoids the classic
  # array-value / nested-hash reorder bug.
  class Session
    PAYLOAD_QUERY_METHODS = %i[get delete].freeze

    def initialize(config)
      @config = config
      @conn = config.faraday_connection || build_connection
    end

    # Public unsigned endpoint — no X-BAPI-* headers attached.
    #   session.public_request(path: '/v5/market/kline', params: {...})
    def public_request(path:, method: :get, params: nil, body: nil)
      dispatch(method: method, path: path, signed: false, params: params, body: body)
    end

    # Signed endpoint — X-BAPI-* headers computed via Authentication.
    def sign_request(method:, path:, params: nil, body: nil)
      dispatch(method: method, path: path, signed: true, params: params, body: body)
    end

    private

    def dispatch(method:, path:, signed:, params:, body:)
      # Only GET / DELETE carry params on the query string. Silently dropping
      # params on POST / PUT / PATCH used to leave codegen typos undiagnosed
      # for weeks — now they raise loudly.
      if params && !PAYLOAD_QUERY_METHODS.include?(method) && !body.nil?
        raise Bybit::ConfigurationError,
              "params: is only valid on GET/DELETE — #{method.to_s.upcase} must pass data via body:"
      end
      clean_params = compact(params)
      clean_body   = compact(body)
      query_str = clean_params ? encode_query(clean_params) : ''
      body_str  = clean_body ? JSON.generate(clean_body) : ''
      headers = build_headers(signed: signed, method: method, query_str: query_str, body_str: body_str)

      # Build URL manually with our own query_str so the wire bytes match
      # what we signed. `req.params =` would re-serialize through
      # Faraday::NestedParamsEncoder which key-orders and array-brackets
      # differently, breaking the signature.
      full_url = if !query_str.empty? && PAYLOAD_QUERY_METHODS.include?(method)
                   "#{path}?#{query_str}"
                 else
                   path
                 end

      resp = @conn.send(method) do |req|
        req.url full_url
        req.headers.update(headers)
        req.body = body_str if clean_body
      end
      parse_response(resp)
    rescue Faraday::TimeoutError => e
      raise Bybit::TimeoutError, e.message
    rescue Faraday::ConnectionFailed => e
      raise Bybit::TimeoutError, e.message if connect_timeout?(e)

      raise Bybit::NetworkError, e.message
    rescue Faraday::SSLError => e
      raise Bybit::NetworkError, e.message
    rescue Faraday::Error => e
      # Catch-all for Faraday::ParsingError / ClientError / ServerError etc.
      # that surface when the caller wires their own error-raising middleware.
      raise Bybit::TransportError, e.message
    end

    # Faraday 2's net_http adapter wraps Net::OpenTimeout / Timeout::Error /
    # Errno::ETIMEDOUT in ConnectionFailed (only Net::ReadTimeout becomes
    # Faraday::TimeoutError). Callers still want these surfaced as TimeoutError.
    def connect_timeout?(err)
      cause = err.respond_to?(:wrapped_exception) ? err.wrapped_exception : nil
      cause.is_a?(Timeout::Error) || cause.is_a?(Errno::ETIMEDOUT)
    end

    # Deterministic `&`-joined encoding, keys sorted, values URI-escaped.
    # Arrays become repeated keys (`symbol=BTCUSDT&symbol=ETHUSDT`) — this
    # matches Bybit V5's flat-list expectation.
    def encode_query(params)
      params.sort_by { |k, _| k.to_s }.flat_map do |k, v|
        key_enc = URI.encode_www_form_component(k.to_s)
        Array(v).map { |single| "#{key_enc}=#{URI.encode_www_form_component(single.to_s)}" }
      end.join('&')
    end

    def build_headers(signed:, method:, query_str:, body_str:)
      h = {}
      h['Content-Type'] = 'application/json' unless body_str.empty?
      return h unless signed
      raise Bybit::ConfigurationError, 'signed endpoint requires api_key + api_secret' if @config.api_key.nil? || @config.api_secret.nil?

      ts = (Time.now.to_f * 1000).to_i.to_s
      # payload for GET/DELETE is query string; for POST/PUT/PATCH it's the
      # JSON body. Both branches use the SAME predicate as dispatch above.
      payload = PAYLOAD_QUERY_METHODS.include?(method) ? query_str : body_str
      h['X-BAPI-API-KEY']     = @config.api_key
      h['X-BAPI-TIMESTAMP']   = ts
      h['X-BAPI-RECV-WINDOW'] = @config.recv_window.to_s
      h['X-BAPI-SIGN']        = Authentication.sign_v5(
        @config.api_secret, ts, @config.api_key, @config.recv_window.to_s, payload
      )
      h['X-BAPI-SIGN-TYPE'] = '2'
      h
    end

    def parse_response(response)
      status = response.status
      raw    = response.body
      body   = raw.is_a?(String) ? safe_parse_json(raw) : raw
      body   = normalize_legacy_body(body) if body.is_a?(Hash)

      # HTTP status wins over retCode when the body isn't a valid ApiResponse.
      # 401/403/429 get their promised AuthError / RateLimitError classes even
      # when a CDN/WAF returns HTML (no retCode); the README documents this
      # contract. 5xx / other non-auth 4xx keep their generic Server/Client
      # buckets so retry and pager logic can tell them apart.
      if !body.is_a?(Hash) || !body['retCode'].is_a?(Integer)
        preview = truncate_for_error(raw)
        if [401, 403].include?(status)
          raise Bybit::AuthError.new(
            "Bybit auth error (status=#{status}): #{preview}", http_status: status
          )
        elsif status == 429
          raise Bybit::RateLimitError.new(
            "Bybit rate limit (status=#{status}): #{preview}", http_status: status
          )
        elsif status >= 500
          raise Bybit::ServerError, "Bybit server error (status=#{status}): #{preview}"
        elsif status >= 400
          raise Bybit::ClientError, "Bybit client error (status=#{status}): #{preview}"
        else
          raise Bybit::ParseError.new(
            "Response is not a valid Bybit V5 ApiResponse (status=#{status}): #{preview}",
            body: raw, http_status: status
          )
        end
      end
      return body if body['retCode'].zero?

      raise Bybit.api_error_from(body, http_status: status)
    end

    # P2P endpoints (and a few legacy V3-derived paths) return the pre-V5
    # envelope: { ret_code, ret_msg, ext_code, ext_info, time_now, result }.
    # Alias the legacy keys into the V5 shape so the rest of the parser and
    # error mapper works uniformly. If the response is already V5, no-op.
    LEGACY_KEY_MAP = {
      'ret_code' => 'retCode',
      'ret_msg' => 'retMsg',
      'ext_info' => 'retExtInfo',
      'time_now' => 'time'
    }.freeze

    def normalize_legacy_body(body)
      return body if body.key?('retCode')
      return body unless body.key?('ret_code')

      LEGACY_KEY_MAP.each do |legacy, v5|
        body[v5] = body.delete(legacy) if body.key?(legacy)
      end
      # `time_now` is a Bybit-legacy float-string; V5 exposes `time` as an
      # integer millisecond epoch. Best-effort coerce so downstream code that
      # compares against V5 `time` doesn't hit a type mismatch.
      body['time'] = (body['time'].to_f * 1000).to_i if body['time'].is_a?(String)
      body
    end

    def safe_parse_json(str)
      JSON.parse(str)
    rescue JSON::ParserError
      nil
    end

    def truncate_for_error(raw)
      return '(nil body)' if raw.nil?

      s = raw.is_a?(String) ? raw : raw.inspect
      s.length > 2048 ? "#{s[0, 2048]}…(truncated)" : s
    end

    # Shallow compact only — inner Hash / Array-of-Hash values pass through.
    # Recursion happens on the wire-key side via WireKeys.camelize.
    def compact(hash)
      return nil if hash.nil?

      hash.reject { |_, v| v.nil? }
    end

    def build_connection
      Faraday.new(url: @config.resolved_base_url, request: { timeout: @config.timeout })
    end
  end
end
