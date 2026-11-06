# frozen_string_literal: true

module Bybit
  module RestApi
    class StrategyService < BaseService
      # Create a strategy order
      #
      # POST /v5/strategy/create
      #
      # @param params [Hash] Request payload. strategy_type: chaseOrder | iceberg | pov | twap.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/strategy/create-strategy
      def create_strategy(**params)
        body = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/strategy/create', body: body)
      end

      # Query trading strategy list with filters
      #
      # GET /v5/strategy/list
      #
      # @option kwargs [String] :strategy_id Strategy ID for exact lookup (UUID format).
      #   If provided, returns only this specific strategy.
      #   Useful for checking status of a known strategy.
      # @option kwargs [String] :status Filter by strategy status.
      #   - "2": Running (currently executing)
      #   - "3" or "4": Terminated (stopped)
      #   - "5": Paused (temporarily halted)
      #   - "6": Untriggered (waiting for trigger price)
      #   Can provide multiple values separated by comma.
      # @option kwargs [String] :symbol Filter by trading pair symbol.
      #   Case-sensitive, must match exactly.
      #   Example: "BTCUSDT", "ETHUSDT"
      # @option kwargs [String] :category Filter by product category.
      #   Useful to separate spot from derivatives strategies.
      # @option kwargs [String] :strategy_type Filter by strategy type.
      #   Useful to view only specific algorithm strategies.
      # @option kwargs [Integer] :begin_time_e0 Start time filter (Unix timestamp in seconds).
      #   Returns strategies created on or after this time.
      #   Example: 1673214964 (Jan 9, 2023)
      # @option kwargs [Integer] :end_time_e0 End time filter (Unix timestamp in seconds).
      #   Returns strategies created before this time.
      #   Must be greater than beginTimeE0 if both provided.
      # @option kwargs [Integer] :page_size Number of results per page.
      #   Default: 20
      #   Maximum: 50
      # @option kwargs [String] :cursor Pagination cursor from previous response.
      #   Use nextCursor value from previous query to get next page.
      #   Empty for first page.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/strategy/strategy-list
      def query_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/strategy/list', params: params)
      end

      # Query orders created by a specific strategy
      #
      # GET /v5/strategy/order-list
      #
      # @param strategy_id [String] Strategy ID to query orders for (UUID format).
      #   This is the parent strategy whose child orders you want to retrieve.
      #   Obtain from strategy creation response or strategy list query.
      # @option kwargs [String] :status Filter by order status.
      #   - "1": Created (active, not filled yet)
      #   - "2": PartiallyFilled (some quantity executed)
      #   - "3": Filled (fully executed)
      #   - "4": Cancelled (order canceled)
      #   - "5": Rejected (order rejected by exchange)
      #   Can filter by multiple statuses.
      # @option kwargs [String] :symbol Filter by trading pair symbol.
      #   Useful if strategy could trade multiple symbols.
      # @option kwargs [Integer] :begin_time_e0 Start time filter (Unix timestamp in seconds).
      #   Returns orders created on or after this time.
      # @option kwargs [Integer] :end_time_e0 End time filter (Unix timestamp in seconds).
      #   Returns orders created before this time.
      # @option kwargs [Integer] :page_size Number of results per page.
      #   Default: 20, Maximum: 50
      # @option kwargs [String] :cursor Pagination cursor from previous response.
      #   Use nextCursor from previous query for next page.
      # @option kwargs [String] :strategy_type Filter by strategy type.
      #   Should match the parent strategy type.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/strategy/order-list
      def query_order_list(strategy_id:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(strategyId: strategy_id))
        @session.sign_request(method: :get, path: '/v5/strategy/order-list', params: params)
      end

      # Stop a running strategy
      #
      # POST /v5/strategy/stop
      #
      # @param strategy_id [String] Strategy ID to stop (UUID format).
      #   Obtained from strategy creation response or strategy list query.
      #   Only Running or Untriggered strategies can be stopped.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/strategy/stop-strategy
      def stop_strategy(strategy_id:)
        params = Bybit::Utils::WireKeys.camelize({ strategyId: strategy_id })
        @session.sign_request(method: :post, path: '/v5/strategy/stop', body: params)
      end
    end
  end
end
