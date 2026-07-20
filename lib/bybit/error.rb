# frozen_string_literal: true

module Bybit
  class Error < StandardError; end

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
  class TimeoutError   < Error;    end
  class NetworkError   < Error;    end

  class ParseError < Error
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
