# frozen_string_literal: true

module Bybit
  module RestApi
    # Endpoints that don't cleanly belong under a per-domain service:
    # announcement feed and system status.
    class MiscService < BaseService
      # Get Announcements
      #
      # GET /v5/announcements/index
      #
      # @param locale [String] Language code, e.g. `en-US`, `zh-TW`.
      # @option kwargs [String] :type Announcement type filter
      # @option kwargs [String] :tag Tag filter
      # @option kwargs [Integer] :page Page number
      # @option kwargs [Integer] :limit Records per page (max 100)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/announcement
      def get_announcements(locale:, **kwargs)
        params = kwargs.merge(locale: locale)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/announcements/index', params: params)
      end

      # Get System Status
      #
      # GET /v5/system/status
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/system-status
      def get_system_status
        @session.public_request(path: '/v5/system/status')
      end
    end
  end
end
