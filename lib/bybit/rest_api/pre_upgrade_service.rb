# frozen_string_literal: true

module Bybit
  module RestApi
    # /v5/pre-upgrade/* — historical queries scoped to activity that occurred
    # BEFORE a Classic → UTA account upgrade. These records live in the legacy
    # partition and never merge into the UTA tables, so callers upgrading from
    # older SDKs need a dedicated namespace to fetch them.
    class PreUpgradeService < BaseService
      # Get Pre-upgrade Order History
      #
      # GET /v5/pre-upgrade/order/history
      #
      # @param category [String] Product type: `linear`, `inverse`, `option`
      # @option kwargs [String] :symbol Symbol filter
      # @option kwargs [String] :base_coin Base coin filter
      # @option kwargs [String] :order_id Order ID filter
      # @option kwargs [String] :order_link_id User-side order link ID
      # @option kwargs [String] :order_filter Order-type filter
      # @option kwargs [String] :order_status Order status filter
      # @option kwargs [Integer] :start_time Start ms timestamp
      # @option kwargs [Integer] :end_time End ms timestamp
      # @option kwargs [Integer] :limit Records per page
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/pre-upgrade/order-list
      def get_order_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/pre-upgrade/order/history', params: params)
      end

      # Get Pre-upgrade Trade (Execution) History
      #
      # GET /v5/pre-upgrade/execution/list
      #
      # @param category [String] Product type: `linear`, `inverse`, `option`
      # @option kwargs [String] :symbol Symbol filter
      # @option kwargs [String] :order_id Order ID filter
      # @option kwargs [String] :order_link_id User-side order link ID
      # @option kwargs [String] :base_coin Base coin filter
      # @option kwargs [Integer] :start_time Start ms timestamp
      # @option kwargs [Integer] :end_time End ms timestamp
      # @option kwargs [String] :exec_type Execution type filter
      # @option kwargs [Integer] :limit Records per page
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/pre-upgrade/execution
      def get_trade_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/pre-upgrade/execution/list', params: params)
      end

      # Get Pre-upgrade Closed PnL
      #
      # GET /v5/pre-upgrade/position/closed-pnl
      #
      # Bybit V5 only requires `symbol` when `category` is `inverse`; for
      # `linear` it's optional. Keep it as an optional kwarg here — callers
      # querying inverse pass it, callers on linear can omit it.
      #
      # @param category [String] Product type: `linear`, `inverse`
      # @option kwargs [String] :symbol Symbol name (required for `inverse`)
      # @option kwargs [Integer] :start_time Start ms timestamp
      # @option kwargs [Integer] :end_time End ms timestamp
      # @option kwargs [Integer] :limit Records per page
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/pre-upgrade/close-pnl
      def get_closed_pnl(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/pre-upgrade/position/closed-pnl', params: params)
      end

      # Get Pre-upgrade Transaction Log (USDC Derivatives wallet)
      #
      # GET /v5/pre-upgrade/account/transaction-log
      #
      # @param category [String] Product type: `linear`, `option`
      # @option kwargs [String] :base_coin Base coin filter
      # @option kwargs [String] :type Transaction type filter
      # @option kwargs [Integer] :start_time Start ms timestamp
      # @option kwargs [Integer] :end_time End ms timestamp
      # @option kwargs [Integer] :limit Records per page
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/pre-upgrade/transaction-log
      def get_transaction_log(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/pre-upgrade/account/transaction-log', params: params)
      end

      # Get Pre-upgrade Option Delivery Record
      #
      # GET /v5/pre-upgrade/asset/delivery-record
      #
      # @param category [String] Product type: `option`
      # @option kwargs [String] :symbol Symbol filter
      # @option kwargs [Integer] :expiry_date Delivery expiry date (YYYYMMDD)
      # @option kwargs [Integer] :limit Records per page
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/pre-upgrade/delivery
      def get_option_delivery_record(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/pre-upgrade/asset/delivery-record', params: params)
      end

      # Get Pre-upgrade USDC Session Settlement Record
      #
      # GET /v5/pre-upgrade/asset/settlement-record
      #
      # @param category [String] Product type: `linear`
      # @option kwargs [String] :symbol Symbol filter
      # @option kwargs [Integer] :limit Records per page
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/pre-upgrade/settlement
      def get_usdc_session_settlement(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/pre-upgrade/asset/settlement-record', params: params)
      end
    end
  end
end
