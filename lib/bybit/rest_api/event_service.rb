# frozen_string_literal: true

module Bybit
  module RestApi
    class EventService < BaseService
      # Get Event Contract Order History
      #
      # GET /v5/event/order-list
      #
      # @option kwargs [String] :symbol Symbol name, e.g. `BTCUSDT-EC`
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User-defined order ID
      # @option kwargs [Integer] :start_time Start time in milliseconds. Default: 7 days ago
      # @option kwargs [Integer] :end_time End time in milliseconds. Default: now
      # @option kwargs [Integer] :limit Number of items per page. Default: `50`, Range: [`1`, `100`]
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/event/trade/order-list
      def get_ec_order_history(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/event/order-list', params: params)
      end

      # Get Event Contract Active Orders
      #
      # GET /v5/event/order-realtime
      #
      # @option kwargs [String] :symbol Symbol name, e.g. `BTCUSDT-EC`
      # @option kwargs [String] :order_id Order ID. If both `orderId` and `orderLinkId` are passed, `orderId` takes priority
      # @option kwargs [String] :order_link_id User-defined order ID
      # @option kwargs [Integer] :limit Number of items per page. Default: `20`, Range: [`1`, `50`]
      # @option kwargs [String] :cursor Pagination cursor. Use `nextPageCursor` from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/event/trade/open-order
      def get_ec_active_orders(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/event/order-realtime', params: params)
      end

      # Get Event Contract Position Info
      #
      # GET /v5/event/positions
      #
      # @option kwargs [String] :symbol Symbol name, e.g. `BTCUSDT-EC`. If not passed, returns all EC positions
      # @option kwargs [String] :base_coin Base coin filter, e.g. `BTC`
      # @option kwargs [String] :settle_coin Settle coin filter, e.g. `USDT`
      # @option kwargs [Integer] :limit Number of items per page. Default: `20`, Range: [`1`, `50`]
      # @option kwargs [String] :cursor Pagination cursor. Use `nextPageCursor` from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/event/trade/position
      def get_ec_position_info(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/event/positions', params: params)
      end

      # Get Event Contract Settlement Records
      #
      # GET /v5/event/settlements
      #
      # @param symbol [String] Symbol name, e.g. `BTCUSDT-EC`
      # @option kwargs [String] :order_id Order ID filter
      # @option kwargs [Integer] :start_time Start time in milliseconds. Default: 7 days ago
      # @option kwargs [Integer] :end_time End time in milliseconds. Default: now
      # @option kwargs [Integer] :limit Number of items per page. Default: `50`, Range: [`1`, `100`]
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/event/trade/settlement
      def get_ec_settlements(symbol:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol))
        @session.sign_request(method: :get, path: '/v5/event/settlements', params: params)
      end

      # Get Event Contract Trade History
      #
      # GET /v5/event/trades
      #
      # @param symbol [String] Symbol name, e.g. `BTCUSDT-EC`
      # @option kwargs [String] :order_id Order ID filter
      # @option kwargs [String] :order_link_id User-defined order ID
      # @option kwargs [Integer] :start_time Start time in milliseconds. Default: 7 days ago
      # @option kwargs [Integer] :end_time End time in milliseconds. Default: now
      # @option kwargs [Integer] :limit Number of items per page. Default: `50`, Range: [`1`, `100`]
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/event/trade/execution
      def get_ec_trade_history(symbol:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol))
        @session.sign_request(method: :get, path: '/v5/event/trades', params: params)
      end
    end
  end
end
