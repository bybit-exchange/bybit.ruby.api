# frozen_string_literal: true

module Bybit
  BASE_URL_MAINNET    = 'https://api.bybit.com'
  BASE_URL_TESTNET    = 'https://api-testnet.bybit.com'
  DEFAULT_RECV_WINDOW = '5000'
  DEFAULT_TIMEOUT     = 10

  class Configuration
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

    # Redact credentials from #inspect and #to_s so a stray puts/logger call
    # doesn't leak the secret into log aggregation.
    def inspect
      "#<Bybit::Configuration api_key=#{redact(@api_key)} api_secret=#{redact(@api_secret)} testnet=#{@testnet} base_url=#{resolved_base_url}>"
    end
    alias_method :to_s, :inspect

    private

    def redact(v)
      v.nil? || v.empty? ? '(unset)' : '[REDACTED]'
    end
  end
end
