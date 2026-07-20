# frozen_string_literal: true

module Bybit
  module RestApi
    class PositionService < BaseService
      # Manually add or reduce margin for an isolated margin position
      #
      # POST /v5/position/add-margin
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param margin [String] Add or reduce. To add, then 10; to reduce, then -10
      # @option kwargs [Integer] :position_idx Used to identify positions in different position modes
      # @see https://bybit-exchange.github.io/docs/v5/position/manual-add-margin
      def add_reduce_margin(category:, symbol:, margin:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, margin: margin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/add-margin', body: params)
      end

      # Confirm new risk limit to remove reduce-only restriction
      #
      # POST /v5/position/confirm-pending-mmr
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @see https://bybit-exchange.github.io/docs/v5/position/confirm-mmr
      def confirm_new_risk_limit(category:, symbol:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/confirm-pending-mmr', body: params)
      end

      # Get closed option position records
      #
      # GET /v5/position/get-closed-positions
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @see https://bybit-exchange.github.io/docs/v5/position/close-position
      def get_close_position(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/position/get-closed-positions', params: params)
      end

      # Get closed profit and loss records
      #
      # GET /v5/position/closed-pnl
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @see https://bybit-exchange.github.io/docs/v5/position/close-pnl
      def get_closed_pnl(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/position/closed-pnl', params: params)
      end

      # Get move position (block trade) history
      #
      # GET /v5/position/move-history
      #
      # @option kwargs [String] :category Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [String] :status Move position status
      # @option kwargs [String] :block_trade_id Block trade ID
      # @option kwargs [String] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @see https://bybit-exchange.github.io/docs/v5/position/move-position-history
      def get_move_position_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/position/move-history', params: params)
      end

      # Get position info (real-time)
      #
      # GET /v5/position/list
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @see https://bybit-exchange.github.io/docs/v5/position
      def get_info_get(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/position/list', params: params)
      end

      # Move positions between UIDs via block trade
      #
      # POST /v5/position/move-positions
      #
      # @param from_uid [String] Original UID (from which the position is moved)
      # @param to_uid [String] Target UID (to which the position is moved)
      # @param list [Array] Positions to move (array of objects)
      # @see https://bybit-exchange.github.io/docs/v5/position/move-position
      def move_position(from_uid:, to_uid:, list:, **kwargs)
        params = kwargs.merge(from_uid: from_uid, to_uid: to_uid, list: list)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/move-positions', body: params)
      end

      # Enable or disable auto-add-margin for a position
      #
      # POST /v5/position/set-auto-add-margin
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param auto_add_margin [Integer] 0: disable, 1: enable
      # @option kwargs [Integer] :position_idx Used to identify positions in different position modes
      # @see https://bybit-exchange.github.io/docs/v5/position/auto-add-margin
      def set_auto_add_margin(category:, symbol:, auto_add_margin:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, auto_add_margin: auto_add_margin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/set-auto-add-margin', body: params)
      end

      # Set leverage for a position
      #
      # POST /v5/position/set-leverage
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param buy_leverage [String] Buy leverage
      # @param sell_leverage [String] Sell leverage
      # @see https://bybit-exchange.github.io/docs/v5/position/leverage
      def set_leverage(category:, symbol:, buy_leverage:, sell_leverage:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, buy_leverage: buy_leverage, sell_leverage: sell_leverage)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/set-leverage', body: params)
      end

      # Set take profit, stop loss, and trailing stop for a position
      #
      # POST /v5/position/trading-stop
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param tpsl_mode [String] TP/SL mode: Full or Partial
      # @param position_idx [Integer] Used to identify positions in different position modes
      # @option kwargs [String] :take_profit Take profit price
      # @option kwargs [String] :stop_loss Stop loss price
      # @option kwargs [String] :trailing_stop Trailing stop
      # @option kwargs [String] :tp_trigger_by Take profit trigger price type
      # @option kwargs [String] :sl_trigger_by Stop loss trigger price type
      # @option kwargs [String] :active_price Trailing stop trigger price
      # @option kwargs [String] :tp_size Take profit size (Partial mode)
      # @option kwargs [String] :sl_size Stop loss size (Partial mode)
      # @option kwargs [String] :tp_limit_price The limit order price when take profit price is triggered
      # @option kwargs [String] :sl_limit_price The limit order price when stop loss price is triggered
      # @option kwargs [String] :tp_order_type Take profit order type: Market or Limit
      # @option kwargs [String] :sl_order_type Stop loss order type: Market or Limit
      # @see https://bybit-exchange.github.io/docs/v5/position/trading-stop
      def set_trading_stop(category:, symbol:, tpsl_mode:, position_idx:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, tpsl_mode: tpsl_mode, position_idx: position_idx)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/trading-stop', body: params)
      end

      # Switch position mode between one-way and hedge mode
      #
      # POST /v5/position/switch-mode
      #
      # @param category [String] Product type
      # @param mode [Integer] Position mode: 0 (Merged Single), 3 (Both Sides)
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :coin Coin
      # @see https://bybit-exchange.github.io/docs/v5/position/position-mode
      def switch_position_mode(category:, mode:, **kwargs)
        params = kwargs.merge(category: category, mode: mode)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/position/switch-mode', body: params)
      end
    end
  end
end
