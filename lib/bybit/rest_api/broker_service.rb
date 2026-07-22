# frozen_string_literal: true

module Bybit
  module RestApi
    class BrokerService < BaseService
      # Distribute voucher
      #
      # POST /v5/broker/award/distribute-award
      #
      # @param account_id [String] Account ID
      # @param award_id [String] Award ID
      # @param spec_code [String] Spec code
      # @param amount [String] Distribution amount
      # @param broker_id [String] Broker ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def distribute_award(account_id:, award_id:, spec_code:, amount:, broker_id:, **kwargs)
        params = kwargs.merge(account_id: account_id, award_id: award_id, spec_code: spec_code, amount: amount, broker_id: broker_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/broker/award/distribute-award', body: params)
      end

      # Get voucher details
      #
      # POST /v5/broker/award/info
      #
      # @param id [String] Voucher ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_award_info(id:, **kwargs)
        params = kwargs.merge(id: id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/broker/award/info', body: params)
      end

      # Query voucher distribution record
      #
      # POST /v5/broker/award/distribution-record
      #
      # @param account_id [String] Account ID
      # @param award_id [String] Award ID
      # @param spec_code [String] Spec code
      # @option kwargs [Boolean] :with_used_amount Include used amount flag
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_distribution_record(account_id:, award_id:, spec_code:, **kwargs)
        params = kwargs.merge(account_id: account_id, award_id: award_id, spec_code: spec_code)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/broker/award/distribution-record', body: params)
      end

      # Get Broker Account Info
      #
      # GET /v5/broker/account-info
      def get_broker_account_info
        @session.sign_request(method: :get, path: '/v5/broker/account-info')
      end

      # Query Broker All UID Rate Limits
      #
      # GET /v5/broker/apilimit/query-all
      #
      # @option kwargs [String] :uids UIDs to query
      # @option kwargs [Integer] :limit Result limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_broker_sub_uids(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/broker/apilimit/query-all', params: params)
      end

      # Query Broker Rate Limit Cap
      #
      # GET /v5/broker/apilimit/query-cap
      def get_broker_rate_limit_cap
        @session.sign_request(method: :get, path: '/v5/broker/apilimit/query-cap')
      end

      # Get Broker Earnings Info
      #
      # GET /v5/broker/earnings-info
      #
      # Bybit's spec names the date-range params `begin` / `end`, which are
      # Ruby keywords — callers use `:start_date` / `:end_date` and we rename
      # them here before camelize. `:begin_` / `:end_` are also accepted (via
      # WireKeys::RESERVED_ALIASES) for callers who prefer the underscore form.
      #
      # @option kwargs [String] :biz_type Business type
      # @option kwargs [String] :start_date Begin date (wire: `begin`)
      # @option kwargs [String] :end_date End date (wire: `end`)
      # @option kwargs [String] :uid Sub UID
      # @option kwargs [Integer] :limit Result limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_broker_earnings(**kwargs)
        params = kwargs.dup
        params[:begin_] = params.delete(:start_date) if params.key?(:start_date)
        params[:end_]   = params.delete(:end_date)   if params.key?(:end_date)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/broker/earnings-info', params: params)
      end

      # Set Broker API Rate Limit
      #
      # POST /v5/broker/apilimit/set
      #
      # @option kwargs [Array] :list List of rate limit config entries
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def set_api_limit(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/broker/apilimit/set', body: params)
      end
    end
  end
end
