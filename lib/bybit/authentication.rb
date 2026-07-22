# frozen_string_literal: true

require 'openssl'

module Bybit
  # HMAC-SHA256 signer for the Bybit V5 REST API.
  # Payload format: timestamp + api_key + recv_window + (query_string OR request_body).
  module Authentication
    module_function

    def sign_v5(api_secret, timestamp, api_key, recv_window, payload)
      msg = "#{timestamp}#{api_key}#{recv_window}#{payload}"
      OpenSSL::HMAC.hexdigest('SHA256', api_secret, msg)
    end
  end
end
