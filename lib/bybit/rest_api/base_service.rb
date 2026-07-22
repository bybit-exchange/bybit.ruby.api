# frozen_string_literal: true

module Bybit
  module RestApi
    class BaseService
      def initialize(session)
        @session = session
      end
    end
  end
end
