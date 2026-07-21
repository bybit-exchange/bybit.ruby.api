# frozen_string_literal: true

require 'json'
require 'openssl'

module Bybit
  module WebSocket
    # Bybit V5 WebSocket client — public streams (spot / linear / inverse /
    # option) and the private user-data stream.
    #
    # Design goals mirror the REST session:
    # - one class, `channel:` selects endpoint (avoids Public/Private class
    #   duplication for ping / subscribe / dispatch logic)
    # - explicit callbacks (`on_message`, `on_open`, `on_close`, `on_error`)
    #   passed as procs; no global registry / singleton
    # - HMAC-SHA256 auth for `:private` is identical to REST signing except
    #   the payload is `"GET/realtime" + expires` — the docs are explicit
    # - ping every `ping_interval` seconds via a lightweight background
    #   thread; server terminates connections after 20s silence
    # - automatic resubscribe on reconnect (topic list is retained across
    #   `#connect` calls) so callers don't lose subscriptions on transient
    #   network blips
    #
    # This class depends on `websocket-client-simple` (a runtime dep of the
    # gem). If missing, requiring it raises a clear LoadError below.
    class Client
      begin
        require 'websocket-client-simple'
      rescue LoadError => e
        raise LoadError,
              "Bybit::WebSocket::Client requires the 'websocket-client-simple' " \
              "gem. Add `gem 'websocket-client-simple'` to your Gemfile. " \
              "(#{e.message})"
      end

      # Channel → WS path (public streams are category-scoped; private has one).
      PUBLIC_CHANNELS = %i[spot linear inverse option].freeze
      PRIVATE_CHANNEL = :private
      TRADE_CHANNEL   = :trade

      PATHS = {
        spot: '/v5/public/spot',
        linear: '/v5/public/linear',
        inverse: '/v5/public/inverse',
        option: '/v5/public/option',
        private: '/v5/private',
        trade: '/v5/trade'
      }.freeze

      HOST_MAINNET = 'stream.bybit.com'
      HOST_TESTNET = 'stream-testnet.bybit.com'

      DEFAULT_PING_INTERVAL = 20
      # Bybit rejects auth expiry timestamps in the past AND >30s in the future.
      DEFAULT_AUTH_EXPIRY_MS = 10_000

      attr_reader :channel, :testnet, :url, :subscriptions

      # @param channel [Symbol] one of `:spot`, `:linear`, `:inverse`,
      #   `:option`, `:private`, `:trade`.
      # @param testnet [Boolean] hit stream-testnet.bybit.com instead of mainnet
      # @param api_key [String] required for `:private` / `:trade`
      # @param api_secret [String] required for `:private` / `:trade`
      # @param ping_interval [Integer] seconds between ping frames (default 20)
      # @param url [String] override the entire WS URL (skips host/path build)
      # @param on_open, on_message, on_close, on_error [Proc]
      def initialize(channel:, testnet: false,
                     api_key: nil, api_secret: nil,
                     ping_interval: DEFAULT_PING_INTERVAL,
                     url: nil,
                     on_open: nil, on_message: nil, on_close: nil, on_error: nil)
        validate_channel!(channel)
        @channel        = channel
        @testnet        = testnet
        @api_key        = api_key
        @api_secret     = api_secret
        @ping_interval  = ping_interval
        @url            = url || build_url
        @on_open        = on_open
        @on_message     = on_message
        @on_close       = on_close
        @on_error       = on_error
        @subscriptions  = []
        @ws             = nil
        @ping_thread    = nil
        @connected      = false
        @auth_ok        = false
        @closing        = false
      end

      # Open the WebSocket, authenticate (if private/trade), and start pinging.
      # Calling `connect` a second time closes the prior socket first, then
      # opens a fresh one and replays any topics buffered in `@subscriptions`
      # (call `disconnect` explicitly if you want to drop them). No automatic
      # reconnect on network drop — the caller decides when to re-open.
      def connect
        require_auth! if requires_auth?
        # Idempotent: tear down any prior socket / ping thread so a second
        # `connect` call doesn't leak the previous ws or leave two pingers.
        disconnect if @ws
        @closing = false
        client = self
        @ws = ::WebSocket::Client::Simple.connect(@url)

        @ws.on(:open)    { client.send(:handle_open) }
        @ws.on(:message) { |msg| client.send(:handle_message, msg) }
        @ws.on(:close)   { |ev|  client.send(:handle_close, ev) }
        @ws.on(:error)   { |err| client.send(:handle_error, err) }
        self
      end

      # Subscribe to one or more topics. Bybit expects an array under `args`:
      #   {"op":"subscribe","args":["orderbook.1.BTCUSDT","tickers.BTCUSDT"]}
      # Callers can call `subscribe` before `connect`; topics are buffered and
      # sent once the socket opens (private streams also wait for auth OK).
      def subscribe(*topics)
        topics = topics.flatten.compact.uniq
        return if topics.empty?

        @subscriptions |= topics
        flush_subscriptions(topics) if ready?
        self
      end

      def unsubscribe(*topics)
        topics = topics.flatten.compact.uniq
        return if topics.empty?

        @subscriptions -= topics
        send_frame(op: 'unsubscribe', args: topics) if ready?
        self
      end

      # Send a WS message directly (escape hatch for placing orders over the
      # `/v5/trade` stream; the docs specify per-op payloads).
      def send_raw(payload)
        return unless @ws

        @ws.send(payload.is_a?(String) ? payload : JSON.generate(payload))
      end

      def disconnect
        @closing = true
        stop_pinger
        @connected = false
        @auth_ok = false
        begin
          @ws&.close
        rescue StandardError
          # Socket may already be half-closed by the peer or in a bad state —
          # we only care about detaching, not about clean protocol shutdown.
        end
        @ws = nil
      end

      def connected?
        @connected
      end

      def ready?
        return false unless @connected

        requires_auth? ? @auth_ok : true
      end

      private

      def validate_channel!(channel)
        allowed = PUBLIC_CHANNELS + [PRIVATE_CHANNEL, TRADE_CHANNEL]
        return if allowed.include?(channel)

        raise Bybit::ConfigurationError,
              "invalid channel: #{channel.inspect} (must be one of #{allowed.inspect})"
      end

      def requires_auth?
        channel == PRIVATE_CHANNEL || channel == TRADE_CHANNEL
      end

      def require_auth!
        return unless @api_key.nil? || @api_secret.nil?

        raise Bybit::ConfigurationError,
              ":#{channel} WebSocket requires api_key + api_secret"
      end

      def build_url
        host = @testnet ? HOST_TESTNET : HOST_MAINNET
        path = PATHS.fetch(channel)
        "wss://#{host}#{path}"
      end

      def handle_open
        @connected = true
        if requires_auth?
          send_auth_frame
        else
          @auth_ok = true
          flush_subscriptions(@subscriptions)
        end
        start_pinger
        @on_open&.call
      end

      def handle_message(raw)
        data = raw.respond_to?(:data) ? raw.data : raw.to_s
        parsed = safe_parse(data)
        if parsed.is_a?(Hash) && parsed['op'] == 'auth'
          # V5 WS auth reply: {"op":"auth","success":true|false,"ret_msg":...}.
          # `success` is authoritative — do NOT treat missing retCode as OK,
          # else a rejection with only ret_msg would silently pass.
          @auth_ok = parsed['success'] == true
          flush_subscriptions(@subscriptions) if @auth_ok
        end
        @on_message&.call(parsed.nil? ? data : parsed)
      end

      def handle_close(event)
        stop_pinger
        @connected = false
        @auth_ok = false
        @on_close&.call(event)
      end

      def handle_error(err)
        # Suppress the noisy IOError the reader thread emits when we close
        # the socket deliberately (see `disconnect`). Real transport errors
        # still fire — @closing only gates the shutdown window.
        return if @closing

        @on_error&.call(err)
      end

      # Ping every `ping_interval` seconds; Bybit closes idle sockets around
      # 20s of silence, so keep this ≤ 20s.
      def start_pinger
        stop_pinger
        ws = @ws
        interval = @ping_interval
        @ping_thread = Thread.new do
          Thread.current.name = "bybit-ws-ping-#{channel}" if Thread.current.respond_to?(:name=)
          loop do
            sleep interval
            break if ws.nil? || ws != @ws

            begin
              ws.send(JSON.generate(op: 'ping'))
            rescue StandardError
              break
            end
          end
        end
      end

      def stop_pinger
        return unless @ping_thread

        begin
          @ping_thread.kill
        rescue StandardError
          nil
        end
        @ping_thread = nil
      end

      def flush_subscriptions(topics)
        return if topics.nil? || topics.empty?

        send_frame(op: 'subscribe', args: topics)
      end

      def send_frame(payload)
        return unless @ws

        @ws.send(JSON.generate(payload))
      end

      # HMAC-SHA256 over "GET/realtime" + expires — the private-stream auth
      # scheme documented at
      # https://bybit-exchange.github.io/docs/v5/ws/connect#authentication
      def send_auth_frame
        expires = (Time.now.to_f * 1000).to_i + DEFAULT_AUTH_EXPIRY_MS
        signature = OpenSSL::HMAC.hexdigest('SHA256', @api_secret, "GET/realtime#{expires}")
        send_frame(op: 'auth', args: [@api_key, expires, signature])
      end

      def safe_parse(str)
        JSON.parse(str)
      rescue JSON::ParserError
        nil
      end
    end
  end
end
