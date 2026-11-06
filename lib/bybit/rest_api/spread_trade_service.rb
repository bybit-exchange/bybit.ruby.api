# frozen_string_literal: true

module Bybit
  module RestApi
    class SpreadTradeService < BaseService
      # Get Trade History
      #
      # GET /v5/spread/execution/list
      #
      # @option kwargs [String] :symbol Spread combination symbol name.
      # @option kwargs [String] :order_id Spread combination order ID.
      # @option kwargs [String] :order_link_id User-defined custom order ID.
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds. See time range logic in description.
      # @option kwargs [Integer] :end_time End timestamp in milliseconds. See time range logic in description.
      # @option kwargs [Integer] :limit Number of results per page. Range `[1, 50]`. Default `20`.
      # @option kwargs [String] :cursor Pagination cursor token from `nextPageCursor` in a previous response.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/execution/list
      def get_history(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spread/execution/list', params: params)
      end

      # Get Spread Instruments Info
      #
      # GET /v5/spread/instrument
      #
      # @option kwargs [String] :symbol Spread combination symbol name, e.g. `SOLUSDT_SOL/USDT`
      # @option kwargs [String] :base_coin Base coin in uppercase, e.g. `SOL`
      # @option kwargs [Integer] :limit Number of records per page, range `[1, 500]`. Default is `200`
      # @option kwargs [String] :cursor Pagination cursor; use `nextPageCursor` from the previous response
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/instrument
      def get_spread_instruments_info(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.public_request(path: '/v5/spread/instrument', params: params)
      end

      # Get Spread Wallet Balance
      #
      # GET /v5/spread/max-qty
      #
      # @param symbol [String] Spread trading pair.
      # @param side [String] Order side:
      #   - `1`: Buy
      #   - `2`: Sell
      # @param order_price [String] Order price.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/max-qty
      def get_spread_max_qty(symbol:, side:, order_price:)
        params = Bybit::Utils::WireKeys.camelize({ symbol: symbol, side: side, orderPrice: order_price })
        @session.sign_request(method: :get, path: '/v5/spread/max-qty', params: params)
      end

      # Amend Order
      #
      # POST /v5/spread/order/amend
      #
      # @param symbol [String] Spread combination symbol name.
      # @option kwargs [String] :order_id Spread combination order ID. Either `orderId` or `orderLinkId` is required.
      # @option kwargs [String] :order_link_id User-defined custom order ID. Either `orderId` or `orderLinkId` is required.
      # @option kwargs [String] :qty New order quantity after modification (string-formatted number).
      #   At least one of `qty` or `price` must be provided.
      # @option kwargs [String] :price New order price after modification (string-formatted number).
      #   At least one of `qty` or `price` must be provided.
      #   - `""` (empty string): keeps the existing price unchanged.
      #   - `"0"`: updates the price to zero.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/order/amend
      def amend_spread_order(symbol:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol))
        @session.sign_request(method: :post, path: '/v5/spread/order/amend', body: params)
      end

      # Cancel Order
      #
      # POST /v5/spread/order/cancel
      #
      # @option kwargs [String] :order_id Spread combination order ID. Either `orderId` or `orderLinkId` is required.
      # @option kwargs [String] :order_link_id User-defined custom order ID. Either `orderId` or `orderLinkId` is required.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/order/cancel
      def cancel_spread_order(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/spread/order/cancel', body: params)
      end

      # Cancel All Orders
      #
      # POST /v5/spread/order/cancel-all
      #
      # @option kwargs [String] :symbol Spread combination symbol name. When specified, all orders for this symbol
      #   are cancelled and `cancelAll` is ignored.
      # @option kwargs [Boolean] :cancel_all Set to `true` to cancel all open orders across all symbols.
      #   Ignored when `symbol` is provided.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/order/cancel-all
      def cancel_all_spread_orders(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/spread/order/cancel-all', body: params)
      end

      # Create Order
      #
      # POST /v5/spread/order/create
      #
      # @param symbol [String] Spread combination symbol name.
      # @param side [String] Order direction.
      # @param order_type [String] Order type.
      # @param qty [String] Order quantity (string-formatted number).
      # @option kwargs [String] :price Order price (string-formatted number). Required for Limit orders.
      #   Not required for Market orders.
      # @option kwargs [String] :order_link_id User-defined custom order identifier. Maximum 45 characters.
      #   Supports alphanumeric characters, dashes, and underscores.
      # @option kwargs [String] :time_in_force Time-in-force strategy for order execution.
      #   - `GTC`: Good Till Cancel (default for Limit).
      #   - `IOC`: Immediate or Cancel.
      #   - `FOK`: Fill or Kill.
      #   - `PostOnly`: Maker-only; rejected if it would take liquidity.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/order/create
      def create_spread_order(symbol:, side:, order_type:, qty:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol, side: side, orderType: order_type, qty: qty))
        @session.sign_request(method: :post, path: '/v5/spread/order/create', body: params)
      end

      # Get Order History
      #
      # GET /v5/spread/order/history
      #
      # @option kwargs [String] :symbol Spread combination symbol name.
      # @option kwargs [String] :base_coin Base coin to filter by.
      # @option kwargs [String] :order_id Spread combination order ID. Has higher priority than time-based filters.
      # @option kwargs [String] :order_link_id User-defined custom order ID. Has higher priority than time-based filters.
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds. See time range logic in description.
      # @option kwargs [Integer] :end_time End timestamp in milliseconds. See time range logic in description.
      # @option kwargs [Integer] :limit Number of results per page. Range `[1, 50]`. Default `20`.
      # @option kwargs [String] :cursor Pagination cursor token from `nextPageCursor` in a previous response.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/order/history
      def get_spread_order_history(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spread/order/history', params: params)
      end

      # Get Open Orders
      #
      # GET /v5/spread/order/realtime
      #
      # @option kwargs [String] :symbol Spread combination symbol name.
      # @option kwargs [String] :base_coin Base coin to filter by.
      # @option kwargs [String] :order_id Spread combination order ID.
      # @option kwargs [String] :order_link_id User-defined custom order ID.
      # @option kwargs [Integer] :limit Number of results per page. Range `[1, 50]`. Default `20`.
      # @option kwargs [String] :cursor Pagination cursor token from `nextPageCursor` in a previous response.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/order/realtime
      def get_spread_open_orders(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spread/order/realtime', params: params)
      end

      # Get Spread Orderbook
      #
      # GET /v5/spread/orderbook
      #
      # @param symbol [String] Spread combination symbol name, e.g. `SOLUSDT_SOL/USDT`
      # @option kwargs [Integer] :limit Number of bid/ask levels per side, range `[1, 25]`. Default is `1`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/orderbook
      def get_spread_orderbook(symbol:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol))
        @session.public_request(path: '/v5/spread/orderbook', params: params)
      end

      # Get Spread Recent Public Trades
      #
      # GET /v5/spread/recent-trade
      #
      # @param symbol [String] Spread combination symbol name, e.g. `SOLUSDT_SOL/USDT`
      # @option kwargs [Integer] :limit Number of records per page, range `[1, 1000]`. Default is `500`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/recent-trade
      def get_spread_recent_trades(symbol:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol))
        @session.public_request(path: '/v5/spread/recent-trade', params: params)
      end

      # Get Spread Tickers
      #
      # GET /v5/spread/tickers
      #
      # @param symbol [String] Spread combination symbol name, e.g. `SOLUSDT_SOL/USDT`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spread/tickers
      def get_spread_tickers(symbol:)
        params = Bybit::Utils::WireKeys.camelize({ symbol: symbol })
        @session.public_request(path: '/v5/spread/tickers', params: params)
      end
    end
  end
end
