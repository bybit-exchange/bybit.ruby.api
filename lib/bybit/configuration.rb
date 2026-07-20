# frozen_string_literal: true

module Bybit
  BASE_URL_MAINNET    = 'https://api.bybit.com'
  BASE_URL_TESTNET    = 'https://api-testnet.bybit.com'
  DEFAULT_RECV_WINDOW = '5000'
  DEFAULT_TIMEOUT     = 10

  class Configuration
    # Attributes safe to expose in serialized form. Anything not in this
    # allowlist is dropped from to_json / as_json / marshal_dump — no accidental
    # secret leakage through pino/winston-style default serializers.
    SAFE_ATTRS = %i[testnet base_url recv_window timeout].freeze

    attr_accessor :api_key, :api_secret, :testnet, :base_url,
                  :recv_window, :timeout, :faraday_connection

    def initialize
      @testnet = false
      @recv_window = DEFAULT_RECV_WINDOW
      @timeout = DEFAULT_TIMEOUT
    end

    def resolved_base_url
      base_url || (testnet ? BASE_URL_TESTNET : BASE_URL_MAINNET)
    end

    # Serialization-safe hash used by as_json / to_json / marshal_dump.
    def to_h_safe
      {
        api_key: redact(@api_key),
        api_secret: redact(@api_secret),
        testnet: @testnet,
        base_url: resolved_base_url,
        recv_window: @recv_window,
        timeout: @timeout
      }
    end

    def to_json(*args)
      require 'json'
      to_h_safe.to_json(*args)
    end

    def as_json(*_)
      to_h_safe.transform_keys(&:to_s)
    end

    def marshal_dump
      to_h_safe
    end

    # Un-marshalling a redacted Configuration is intentionally lossy — callers
    # should never round-trip credentials through Marshal.
    def marshal_load(hash)
      hash.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    # Redact credentials from #inspect and #to_s so a stray puts/logger call
    # doesn't leak the secret into log aggregation.
    def inspect
      "#<Bybit::Configuration api_key=#{redact(@api_key)} api_secret=#{redact(@api_secret)} testnet=#{@testnet} base_url=#{resolved_base_url}>"
    end
    alias to_s inspect

    private

    def redact(value)
      # Use .to_s.empty? so an Integer / other non-String credential (rare but
      # possible via misconfig) doesn't crash with NoMethodError.
      value.nil? || value.to_s.empty? ? '(unset)' : '[REDACTED]'
    end
  end
end
