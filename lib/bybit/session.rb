# frozen_string_literal: true

require 'faraday'
require 'json'
require 'uri'

module Bybit
  # Session owns the Faraday connection + auth-header assembly. Every service
  # class receives a Session instance and dispatches through public_request /
  # sign_request. Modeled after binance-connector-ruby's Session pattern.
  class Session
    SENSITIVE_HEADERS = %w[
      x-bapi-api-key x-bapi-sign x-bapi-timestamp x-bapi-recv-window
      x-bapi-sign-type authorization cookie set-cookie
    ].freeze

    def initialize(config)
      @config = config
      @conn = config.faraday_connection || build_connection
    end

    # Public unsigned endpoint — no X-BAPI-* headers attached.
    #   session.public_request(path: '/v5/market/kline', params: {...})
    def public_request(method: :get, path:, params: nil, body: nil)
      dispatch(method: method, path: path, signed: false, params: params, body: body)
    end

    # Signed endpoint — X-BAPI-* headers computed via Authentication.
    def sign_request(method:, path:, params: nil, body: nil)
      dispatch(method: method, path: path, signed: true, params: params, body: body)
    end

    private

    def dispatch(method:, path:, signed:, params:, body:)
      clean_params = compact(params)
      clean_body   = compact(body)
      query_str = clean_params ? URI.encode_www_form(clean_params) : ''
      body_str  = clean_body ? JSON.generate(clean_body) : ''
      headers = build_headers(signed: signed, method: method, query_str: query_str, body_str: body_str)

      resp = @conn.send(method) do |req|
        req.url path
        req.params = clean_params if clean_params && [:get, :delete].include?(method)
        req.headers.update(headers)
        req.body = body_str if clean_body
      end
      parse_response(resp)
    rescue Faraday::TimeoutError => e
      raise Bybit::TimeoutError, e.message
    rescue Faraday::ConnectionFailed, Faraday::SSLError => e
      raise Bybit::NetworkError, e.message
    end

    def build_headers(signed:, method:, query_str:, body_str:)
      h = {}
      h['Content-Type'] = 'application/json' unless body_str.empty?
      return h unless signed
      if @config.api_key.nil? || @config.api_secret.nil?
        raise ArgumentError, 'signed endpoint requires api_key + api_secret'
      end
      ts = (Time.now.to_f * 1000).to_i.to_s
      payload = method == :get ? query_str : body_str
      h['X-BAPI-API-KEY']     = @config.api_key
      h['X-BAPI-TIMESTAMP']   = ts
      h['X-BAPI-RECV-WINDOW'] = @config.recv_window.to_s
      h['X-BAPI-SIGN']        = Authentication.sign_v5(
        @config.api_secret, ts, @config.api_key, @config.recv_window.to_s, payload
      )
      h['X-BAPI-SIGN-TYPE']   = '2'
      h
    end

    def parse_response(response)
      body = response.body
      body = safe_parse_json(body) if body.is_a?(String)
      unless body.is_a?(Hash) && body['retCode'].is_a?(Integer)
        raise Bybit::ParseError.new(
          "Response is not a valid Bybit V5 ApiResponse (status=#{response.status})",
          body: body, http_status: response.status
        )
      end
      return body if body['retCode'] == 0
      raise Bybit.api_error_from(body, http_status: response.status)
    end

    def safe_parse_json(str)
      JSON.parse(str)
    rescue JSON::ParserError
      nil
    end

    def compact(hash)
      return nil if hash.nil?
      hash.reject { |_, v| v.nil? }
    end

    def build_connection
      Faraday.new(url: @config.resolved_base_url, request: { timeout: @config.timeout })
    end
  end
end
