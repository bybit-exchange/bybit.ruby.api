# frozen_string_literal: true

module Bybit
  module RestApi
    class AffiliateService < BaseService
      # Get affiliate sub-affiliate list
      #
      # GET /v5/affiliate/affiliate-sub-list
      #
      # @option kwargs [String] :cursor Cursor for pagination
      # @option kwargs [Integer] :size Page size
      # @option kwargs [String] :start_date Start date filter
      # @option kwargs [String] :end_date End date filter
      # @option kwargs [Integer] :sub_aff_id Sub-affiliate ID
      # @see https://bybit-exchange.github.io/docs/v5/affiliate/affiliate-sub-list
      def get_sub_list(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/affiliate/affiliate-sub-list', params: params)
      end

      # Get affiliate user list
      #
      # GET /v5/affiliate/aff-user-list
      #
      # @option kwargs [String] :cursor Cursor for pagination
      # @option kwargs [Integer] :size Page size
      # @option kwargs [Boolean] :need_deposit Whether to include deposit information
      # @option kwargs [Boolean] :need30 Whether to include 30-day statistics
      # @option kwargs [Boolean] :need365 Whether to include 365-day statistics
      # @option kwargs [String] :start_date Start date filter
      # @option kwargs [String] :end_date End date filter
      def get_user_list(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/affiliate/aff-user-list', params: params)
      end
    end
  end
end
