# frozen_string_literal: true

module Bybit
  # Root class for every failure the SDK raises. `rescue Bybit::Error`
  # catches everything — auth, rate-limit, timeout, network, parse, misconfig.
  class Error < StandardError; end

  # Configuration mistake caught before the network call (missing api_key,
  # invalid combination of options). Distinct from AuthError which is a
  # server-side rejection.
  class ConfigurationError < Error; end

  # Transport-level errors that don't fit Timeout / Network / a Bybit body.
  # Faraday::ParsingError / ClientError / ServerError land here.
  class TransportError < Error; end

  # 5xx HTTP without a decodable Bybit body — infra outage / gateway error.
  class ServerError < TransportError; end

  # Non-auth 4xx HTTP without a decodable Bybit body — usually WAF / CDN.
  class ClientError < TransportError; end

  # Raised when the server returns HTTP 200 + retCode != 0 (the V5 norm),
  # or when a transport-level error is enriched with a Bybit body payload.
  class ApiError < Error
    attr_reader :ret_code, :ret_msg, :result, :time, :http_status

    def initialize(response, http_status: nil)
      @ret_code    = response['retCode']
      @ret_msg     = response['retMsg']
      @result      = response['result']
      @time        = response['time']
      @http_status = http_status
      super("[#{@ret_code}] #{@ret_msg}")
    end
  end

  class AuthError      < ApiError; end
  class RateLimitError < ApiError; end
  class TimeoutError   < TransportError; end
  class NetworkError   < TransportError; end

  # Body did not parse or didn't match Bybit V5 ApiResponse shape. `body`
  # holds the raw payload (truncated in the message but full in the attr)
  # so consumers can log CDN / maintenance-page HTML for post-mortem.
  class ParseError < TransportError
    attr_reader :body, :http_status
    def initialize(message, body: nil, http_status: nil)
      @body = body
      @http_status = http_status
      super(message)
    end
  end

  AUTH_RET_CODES       = [10002, 10003, 10004, 10005, 10007, 10009, 10010, 10029].freeze
  RATE_LIMIT_RET_CODES = [10006, 10018].freeze

  # Route a V5 response with retCode != 0 to the most specific error subclass.
  def self.api_error_from(response, http_status: nil)
    code = response['retCode']
    return AuthError.new(response, http_status: http_status)      if AUTH_RET_CODES.include?(code)
    return RateLimitError.new(response, http_status: http_status) if RATE_LIMIT_RET_CODES.include?(code)
    ApiError.new(response, http_status: http_status)
  end
end
