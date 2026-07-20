# frozen_string_literal: true

module Bybit
  module RestApi
    class TradeService < BaseService
      # Get Trade History
      #
      # GET /v5/execution/list
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @option kwargs [Integer] :start_time The start timestamp (ms)
      # @option kwargs [Integer] :end_time The end timestamp (ms)
      # @option kwargs [String] :exec_type Execution type
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/execution
      def get_execution_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/execution/list', params: params)
      end

      # Amend an open unfilled or partially filled order.
      #
      # POST /v5/order/amend
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [String] :order_iv Implied volatility (options)
      # @option kwargs [String] :trigger_price Trigger price
      # @option kwargs [String] :qty Order quantity
      # @option kwargs [String] :price Order price
      # @option kwargs [String] :tpsl_mode TP/SL mode
      # @option kwargs [String] :take_profit Take profit price
      # @option kwargs [String] :stop_loss Stop loss price
      # @option kwargs [String] :tp_trigger_by Take profit trigger price type
      # @option kwargs [String] :sl_trigger_by Stop loss trigger price type
      # @option kwargs [String] :trigger_by Trigger price type
      # @option kwargs [String] :tp_limit_price Take profit limit price
      # @option kwargs [String] :sl_limit_price Stop loss limit price
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/amend-order
      def amend_order(category:, symbol:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/amend', body: params)
      end

      # Batch amend multiple orders in a single request.
      #
      # POST /v5/order/amend-batch
      #
      # @param category [String] Product type
      # @param request [Array] Array of order amend objects
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/batch-amend
      def batch_amend_orders(category:, request:, **kwargs)
        params = kwargs.merge(category: category, request: request)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/amend-batch', body: params)
      end

      # Batch cancel multiple orders in a single request.
      #
      # POST /v5/order/cancel-batch
      #
      # @param category [String] Product type
      # @param request [Array] Array of order cancel objects
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/batch-cancel
      def batch_cancel_orders(category:, request:, **kwargs)
        params = kwargs.merge(category: category, request: request)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/cancel-batch', body: params)
      end

      # Batch place multiple orders in a single request.
      #
      # POST /v5/order/create-batch
      #
      # @param category [String] Product type
      # @param request [Array] Array of order create objects
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/batch-place
      def batch_create_orders(category:, request:, **kwargs)
        params = kwargs.merge(category: category, request: request)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/create-batch', body: params)
      end

      # Cancel all open orders for a product line, symbol, or coin.
      #
      # POST /v5/order/cancel-all
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @option kwargs [String] :order_filter Order filter
      # @option kwargs [String] :stop_order_type Stop order type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/cancel-all
      def cancel_all_orders(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/cancel-all', body: params)
      end

      # Cancel a single open order by orderId or orderLinkId.
      #
      # POST /v5/order/cancel
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [String] :order_filter Order filter
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/cancel-order
      def cancel_order(category:, symbol:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/cancel', body: params)
      end

      # Place a new order for spot, linear, inverse, or option products.
      #
      # POST /v5/order/create
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param side [String] Buy or Sell
      # @param order_type [String] Market or Limit
      # @param qty [String] Order quantity
      # @option kwargs [Integer] :is_leverage Whether to borrow (spot margin)
      # @option kwargs [String] :market_unit Unit for spot market order quantity
      # @option kwargs [String] :slippage_tolerance_type Slippage tolerance type
      # @option kwargs [String] :slippage_tolerance Slippage tolerance value
      # @option kwargs [String] :price Order price
      # @option kwargs [Integer] :trigger_direction Conditional order trigger direction
      # @option kwargs [String] :order_filter Order filter
      # @option kwargs [String] :trigger_price Trigger price
      # @option kwargs [String] :trigger_by Trigger price type
      # @option kwargs [String] :order_iv Implied volatility (options)
      # @option kwargs [String] :time_in_force Time in force
      # @option kwargs [Integer] :position_idx Position mode index
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [String] :take_profit Take profit price
      # @option kwargs [String] :stop_loss Stop loss price
      # @option kwargs [String] :tp_trigger_by Take profit trigger price type
      # @option kwargs [String] :sl_trigger_by Stop loss trigger price type
      # @option kwargs [Boolean] :reduce_only Reduce-only flag
      # @option kwargs [Boolean] :close_on_trigger Close on trigger flag
      # @option kwargs [String] :smp_type Self match prevention type
      # @option kwargs [Boolean] :mmp Market maker protection flag (options)
      # @option kwargs [String] :tpsl_mode TP/SL mode
      # @option kwargs [String] :tp_limit_price Take profit limit price
      # @option kwargs [String] :sl_limit_price Stop loss limit price
      # @option kwargs [String] :tp_order_type Take profit order type
      # @option kwargs [String] :sl_order_type Stop loss order type
      # @option kwargs [String] :bbo_side_type BBO side type
      # @option kwargs [String] :bbo_level BBO level
      # @option kwargs [Boolean] :rpi_taker_access RPI taker access flag
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/create-order
      def create_order(category:, symbol:, side:, order_type:, qty:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, side: side, order_type: order_type, qty: qty)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/create', body: params)
      end

      # Set DCP time window (alias endpoint for Disconnected Cancel All Protection).
      #
      # POST /v5/order/disconnected-cancel-all
      #
      # @param time_window [Integer] DCP time window in seconds
      # @option kwargs [String] :product Product type for DCP
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/dcp
      def set_dcp_time_window(time_window:, **kwargs)
        params = kwargs.merge(time_window: time_window)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/disconnected-cancel-all', body: params)
      end

      # Query unfilled or partially filled orders in real-time.
      #
      # GET /v5/order/realtime
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [Integer] :open_only Open-only filter
      # @option kwargs [String] :order_filter Order filter
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/open-order
      def get_open_orders(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/order/realtime', params: params)
      end

      # Query historical orders that have been fully filled or cancelled.
      #
      # GET /v5/order/history
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [String] :order_filter Order filter
      # @option kwargs [String] :order_status Order status
      # @option kwargs [Integer] :start_time Start time (ms)
      # @option kwargs [Integer] :end_time End time (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/order-list
      def get_order_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/order/history', params: params)
      end

      # Query the available borrow quota for spot margin trading.
      #
      # GET /v5/order/spot-borrow-check
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param side [String] Buy or Sell
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/spot-borrow-quota
      def get_spot_borrow_quota(category:, symbol:, side:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, side: side)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/order/spot-borrow-check', params: params)
      end

      # Pre-check an order before submission to validate parameters and margin.
      #
      # POST /v5/order/pre-check
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param side [String] Buy or Sell
      # @param order_type [String] Market or Limit
      # @param qty [String] Order quantity
      # @option kwargs [String] :price Order price
      # @option kwargs [Integer] :is_leverage Whether to borrow (spot margin)
      # @option kwargs [String] :time_in_force Time in force
      # @option kwargs [Integer] :position_idx Position mode index
      # @option kwargs [String] :order_link_id User customised order ID
      # @option kwargs [String] :take_profit Take profit price
      # @option kwargs [String] :stop_loss Stop loss price
      # @option kwargs [String] :tp_trigger_by Take profit trigger price type
      # @option kwargs [String] :sl_trigger_by Stop loss trigger price type
      # @option kwargs [Boolean] :reduce_only Reduce-only flag
      # @option kwargs [String] :tpsl_mode TP/SL mode
      # @option kwargs [String] :tp_limit_price Take profit limit price
      # @option kwargs [String] :sl_limit_price Stop loss limit price
      # @option kwargs [String] :tp_order_type Take profit order type
      # @option kwargs [String] :sl_order_type Stop loss order type
      # @option kwargs [String] :order_iv Implied volatility (options)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/order/pre-check-order
      def pre_check_order(category:, symbol:, side:, order_type:, qty:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, side: side, order_type: order_type, qty: qty)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/order/pre-check', body: params)
      end
    end
  end
end
