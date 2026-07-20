# frozen_string_literal: true

module Bybit
  module RestApi
    class BotService < BaseService
      # Close a running DCA bot with a specified settlement mode
      #
      # POST /v5/dca/close-bot
      #
      # @param bot_id [Integer] Identifier of the DCA bot to close
      # @param close_mode [Integer] Settlement mode used to close the bot
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def close_dca_bot(bot_id:, close_mode:, **kwargs)
        body = kwargs.merge(bot_id: bot_id, close_mode: close_mode)
        @session.sign_request(method: :post, path: '/v5/dca/close-bot', body: body)
      end

      # Create a new DCA (Dollar-Cost Averaging) bot with custom parameters
      #
      # POST /v5/dca/create-bot
      #
      # @param parameters [Hash] DCA bot configuration parameters
      # @option kwargs [Hash] :tools_discovery_parameter Tools discovery parameter object
      # @option kwargs [String] :channel Channel identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def create_dca_bot(parameters:, **kwargs)
        body = kwargs.merge(parameters: parameters)
        @session.sign_request(method: :post, path: '/v5/dca/create-bot', body: body)
      end

      # Close a running futures combo bot by bot ID
      #
      # POST /v5/fcombobot/close
      #
      # @param bot_id [Integer] Combo bot ID to close
      # @option kwargs [Integer] :stop_type Stop type identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def close_combo_bot(bot_id:, **kwargs)
        body = kwargs.merge(bot_id: bot_id)
        @session.sign_request(method: :post, path: '/v5/fcombobot/close', body: body)
      end

      # Create a new futures combo bot with multi-symbol portfolio and rebalancing
      #
      # POST /v5/fcombobot/create
      #
      # @param leverage [String] Leverage setting for the combo bot
      # @param init_margin [String] Initial margin for the combo bot
      # @param adjust_position_mode [Integer] Position adjustment mode
      # @param symbol_settings [Array] Per-symbol configuration settings for the combo bot
      # @option kwargs [String] :adjust_position_percent Position adjustment percent
      # @option kwargs [Integer] :adjust_position_time_interval Position adjustment time interval
      # @option kwargs [String] :sl_percent Stop loss percent
      # @option kwargs [String] :tp_percent Take profit percent
      # @option kwargs [Integer] :source Source identifier
      # @option kwargs [Integer] :block_source Block source identifier
      # @option kwargs [Integer] :create_type Bot creation type
      # @option kwargs [Integer] :followed_bot_id ID of the bot being followed
      # @option kwargs [String] :init_bonus Initial bonus amount
      # @option kwargs [String] :trailing_stop_percent Trailing stop percent
      # @option kwargs [String] :channel Channel identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def create_combo_bot(leverage:, init_margin:, adjust_position_mode:, symbol_settings:, **kwargs)
        body = kwargs.merge(
          leverage: leverage,
          init_margin: init_margin,
          adjust_position_mode: adjust_position_mode,
          symbol_settings: symbol_settings
        )
        @session.sign_request(method: :post, path: '/v5/fcombobot/create', body: body)
      end

      # Get full details of a futures combo bot including PnL, positions, and status
      #
      # POST /v5/fcombobot/detail
      #
      # @param bot_id [Integer] Combo bot ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_combo_detail(bot_id:, **kwargs)
        body = kwargs.merge(bot_id: bot_id)
        @session.sign_request(method: :post, path: '/v5/fcombobot/detail', body: body)
      end

      # Validate combo bot input parameters and return allowable ranges
      #
      # POST /v5/fcombobot/getlimit
      #
      # @param leverage [String] Leverage setting
      # @param init_margin [String] Initial margin
      # @param adjust_position_mode [Integer] Position adjustment mode
      # @param symbol_settings [Array] Per-symbol configuration settings
      # @option kwargs [String] :adjust_position_percent Position adjustment percent
      # @option kwargs [Integer] :adjust_position_time_interval Position adjustment time interval
      # @option kwargs [String] :sl_percent Stop loss percent
      # @option kwargs [String] :tp_percent Take profit percent
      # @option kwargs [Boolean] :need_to_slippage Whether to include slippage in validation
      # @option kwargs [String] :app_name Application name identifier
      # @option kwargs [String] :trailing_stop_percent Trailing stop percent
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_combo_limit(leverage:, init_margin:, adjust_position_mode:, symbol_settings:, **kwargs)
        body = kwargs.merge(
          leverage: leverage,
          init_margin: init_margin,
          adjust_position_mode: adjust_position_mode,
          symbol_settings: symbol_settings
        )
        @session.sign_request(method: :post, path: '/v5/fcombobot/getlimit', body: body)
      end

      # Close a running futures grid bot by bot ID
      #
      # POST /v5/fgridbot/close
      #
      # @param bot_id [Integer] Bot ID of the futures grid bot to close
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def close_futures_grid_bot(bot_id:, **kwargs)
        body = kwargs.merge(bot_id: bot_id)
        @session.sign_request(method: :post, path: '/v5/fgridbot/close', body: body)
      end

      # Create a new futures grid trading bot with specified parameters
      #
      # POST /v5/fgridbot/create
      #
      # @param symbol [String] Trading symbol
      # @param grid_mode [Integer] Grid mode selector
      # @param min_price [String] Lower bound of the grid price range
      # @param max_price [String] Upper bound of the grid price range
      # @param cell_number [Integer] Number of grid cells
      # @param leverage [String] Leverage to use for the grid bot
      # @param grid_type [Integer] Grid type (arithmetic/geometric)
      # @param total_investment [String] Total investment amount
      # @option kwargs [String] :take_profit_per Take profit percentage
      # @option kwargs [String] :stop_loss_per Stop loss percentage
      # @option kwargs [String] :entry_price Entry price for the bot
      # @option kwargs [Integer] :source Source identifier
      # @option kwargs [Integer] :followed_grid_id ID of the grid bot being copied
      # @option kwargs [Hash] :tools_discovery_parameter Tools discovery parameter payload
      # @option kwargs [String] :stop_loss_price Stop loss trigger price
      # @option kwargs [String] :take_profit_price Take profit trigger price
      # @option kwargs [Integer] :tp_sl_type Take-profit/stop-loss type
      # @option kwargs [Integer] :block_source Block source identifier
      # @option kwargs [Integer] :create_type Create type identifier
      # @option kwargs [String] :init_bonus Initial bonus amount
      # @option kwargs [String] :business_remark Business remark note
      # @option kwargs [String] :trailing_stop_per Trailing stop percentage
      # @option kwargs [String] :move_up_price Move-up trigger price
      # @option kwargs [String] :move_down_price Move-down trigger price
      # @option kwargs [String] :channel Client channel identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def create_futures_grid_bot(symbol:, grid_mode:, min_price:, max_price:, cell_number:, leverage:, grid_type:, total_investment:, **kwargs)
        body = kwargs.merge(
          symbol: symbol,
          grid_mode: grid_mode,
          min_price: min_price,
          max_price: max_price,
          cell_number: cell_number,
          leverage: leverage,
          grid_type: grid_type,
          total_investment: total_investment
        )
        @session.sign_request(method: :post, path: '/v5/fgridbot/create', body: body)
      end

      # Get full details of a futures grid bot including PnL, positions, and status
      #
      # POST /v5/fgridbot/detail
      #
      # @param bot_id [Integer] Bot ID of the futures grid bot
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_futures_grid_detail(bot_id:, **kwargs)
        body = kwargs.merge(bot_id: bot_id)
        @session.sign_request(method: :post, path: '/v5/fgridbot/detail', body: body)
      end

      # Validate futures grid bot input parameters and return allowable ranges
      #
      # POST /v5/fgridbot/validate
      #
      # @param symbol [String] Trading symbol
      # @param cell_number [Integer] Number of grid cells
      # @param min_price [String] Lower bound of the grid price range
      # @param max_price [String] Upper bound of the grid price range
      # @param leverage [String] Leverage to validate
      # @param grid_type [Integer] Grid type (arithmetic/geometric)
      # @param grid_mode [Integer] Grid mode selector
      # @option kwargs [String] :stop_loss_price Stop loss trigger price
      # @option kwargs [String] :take_profit_price Take profit trigger price
      # @option kwargs [Integer] :tp_sl_type Take-profit/stop-loss type
      # @option kwargs [String] :entry_price Entry price
      # @option kwargs [String] :stop_loss_per Stop loss percentage
      # @option kwargs [String] :take_profit_per Take profit percentage
      # @option kwargs [String] :trailing_stop_per Trailing stop percentage
      # @option kwargs [String] :init_margin Initial margin amount
      # @option kwargs [String] :move_up_price Move-up trigger price
      # @option kwargs [String] :move_down_price Move-down trigger price
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def validate_futures_grid_input(symbol:, cell_number:, min_price:, max_price:, leverage:, grid_type:, grid_mode:, **kwargs)
        body = kwargs.merge(
          symbol: symbol,
          cell_number: cell_number,
          min_price: min_price,
          max_price: max_price,
          leverage: leverage,
          grid_type: grid_type,
          grid_mode: grid_mode
        )
        @session.sign_request(method: :post, path: '/v5/fgridbot/validate', body: body)
      end

      # Close a running futures Martingale bot by bot ID
      #
      # POST /v5/fmartingalebot/close
      #
      # @param bot_id [Integer] Bot ID
      # @option kwargs [String] :stop_type Stop type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def close_futures_martingale_bot(bot_id:, **kwargs)
        body = kwargs.merge(bot_id: bot_id)
        @session.sign_request(method: :post, path: '/v5/fmartingalebot/close', body: body)
      end

      # Create a new futures Martingale bot with DCA averaging strategy
      #
      # POST /v5/fmartingalebot/create
      #
      # @param symbol [String] Trading symbol
      # @param martingale_mode [String] Martingale mode
      # @param leverage [String] Leverage
      # @param price_float_percent [String] Price float percent triggering next add position
      # @param add_position_percent [String] Add position percent per averaging step
      # @param add_position_num [Integer] Number of add position steps
      # @param init_margin [String] Initial margin
      # @param round_tp_percent [String] Round take-profit percent
      # @option kwargs [String] :auto_cycle_toggle Auto cycle toggle
      # @option kwargs [String] :sl_percent Stop-loss percent
      # @option kwargs [String] :entry_price Entry price
      # @option kwargs [String] :source Source
      # @option kwargs [Integer] :followed_bot_id Followed bot ID
      # @option kwargs [String] :block_source Block source
      # @option kwargs [String] :create_type Create type
      # @option kwargs [String] :init_bonus Initial bonus
      # @option kwargs [String] :channel Channel
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def create_futures_martingale_bot(symbol:, martingale_mode:, leverage:, price_float_percent:, add_position_percent:, add_position_num:, init_margin:, round_tp_percent:, **kwargs)
        body = kwargs.merge(
          symbol: symbol,
          martingale_mode: martingale_mode,
          leverage: leverage,
          price_float_percent: price_float_percent,
          add_position_percent: add_position_percent,
          add_position_num: add_position_num,
          init_margin: init_margin,
          round_tp_percent: round_tp_percent
        )
        @session.sign_request(method: :post, path: '/v5/fmartingalebot/create', body: body)
      end

      # Get full details of a futures Martingale bot including PnL, positions, and round progress
      #
      # POST /v5/fmartingalebot/detail
      #
      # @param bot_id [Integer] Bot ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_futures_martingale_detail(bot_id:, **kwargs)
        body = kwargs.merge(bot_id: bot_id)
        @session.sign_request(method: :post, path: '/v5/fmartingalebot/detail', body: body)
      end

      # Validate Martingale bot input parameters and return allowable ranges
      #
      # POST /v5/fmartingalebot/getlimit
      #
      # @param symbol [String] Trading symbol
      # @param martingale_mode [String] Martingale mode
      # @param leverage [String] Leverage
      # @option kwargs [String] :price_float_percent Price float percent
      # @option kwargs [String] :add_position_percent Add position percent
      # @option kwargs [Integer] :add_position_num Number of add position steps
      # @option kwargs [String] :init_margin Initial margin
      # @option kwargs [String] :round_tp_percent Round take-profit percent
      # @option kwargs [String] :sl_percent Stop-loss percent
      # @option kwargs [String] :entry_price Entry price
      # @option kwargs [Boolean] :need_to_slippage Whether to include slippage
      # @option kwargs [String] :app_name App name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_futures_martingale_limit(symbol:, martingale_mode:, leverage:, **kwargs)
        body = kwargs.merge(
          symbol: symbol,
          martingale_mode: martingale_mode,
          leverage: leverage
        )
        @session.sign_request(method: :post, path: '/v5/fmartingalebot/getlimit', body: body)
      end

      # Close a running spot grid bot with a specified settlement mode
      #
      # POST /v5/grid/close-grid
      #
      # @param grid_id [Integer] Grid bot ID
      # @param close_mode [Integer] Close/settlement mode
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def close_grid_bot(grid_id:, close_mode:, **kwargs)
        body = kwargs.merge(grid_id: grid_id, close_mode: close_mode)
        @session.sign_request(method: :post, path: '/v5/grid/close-grid', body: body)
      end

      # Create a new spot grid trading bot
      #
      # POST /v5/grid/create-grid
      #
      # @param symbol [String] Trading pair symbol
      # @param max_price [String] Upper bound price of the grid
      # @param min_price [String] Lower bound price of the grid
      # @param total_investment [String] Total investment amount
      # @param cell_number [Integer] Number of grid cells
      # @option kwargs [Integer] :followed_grid_id ID of the grid bot being copied/followed
      # @option kwargs [Integer] :source Creation source identifier
      # @option kwargs [String] :entry_price Entry price for the bot
      # @option kwargs [String] :stop_loss_price Stop loss price
      # @option kwargs [String] :take_profit_price Take profit price
      # @option kwargs [Hash] :tools_discovery_parameter Tools discovery parameter object
      # @option kwargs [String] :base_investment Base asset investment amount
      # @option kwargs [String] :quote_investment Quote asset investment amount
      # @option kwargs [Integer] :invest_mode Investment mode
      # @option kwargs [Integer] :block_source Block source identifier
      # @option kwargs [Integer] :create_type Creation type
      # @option kwargs [String] :ts_percent Trailing stop percent
      # @option kwargs [Boolean] :enable_trailing Whether to enable trailing
      # @option kwargs [String] :limit_up_price Upper limit price
      # @option kwargs [String] :channel Channel identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def create_grid_bot(symbol:, max_price:, min_price:, total_investment:, cell_number:, **kwargs)
        body = kwargs.merge(
          symbol: symbol,
          max_price: max_price,
          min_price: min_price,
          total_investment: total_investment,
          cell_number: cell_number
        )
        @session.sign_request(method: :post, path: '/v5/grid/create-grid', body: body)
      end

      # Query full details of a specific grid bot by grid_id
      #
      # POST /v5/grid/query-grid-detail
      #
      # @param grid_id [Integer] Grid bot ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_grid_detail(grid_id:, **kwargs)
        body = kwargs.merge(grid_id: grid_id)
        @session.sign_request(method: :post, path: '/v5/grid/query-grid-detail', body: body)
      end

      # Validate spot grid bot parameters before creation
      #
      # POST /v5/grid/validate-input
      #
      # @param symbol [String] Trading pair symbol
      # @param cell_number [Integer] Number of grid cells
      # @param min_price [String] Lower bound price of the grid
      # @param max_price [String] Upper bound price of the grid
      # @param total_investment [String] Total investment amount
      # @option kwargs [String] :stop_loss Stop loss price
      # @option kwargs [String] :take_profit Take profit price
      # @option kwargs [String] :entry_price Entry price for the bot
      # @option kwargs [String] :base_investment Base asset investment amount
      # @option kwargs [String] :quote_investment Quote asset investment amount
      # @option kwargs [Integer] :invest_mode Investment mode
      # @option kwargs [String] :ts_percent Trailing stop percent
      # @option kwargs [Boolean] :enable_trailing Whether to enable trailing
      # @option kwargs [String] :limit_up_price Upper limit price
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def validate_grid_input(symbol:, cell_number:, min_price:, max_price:, total_investment:, **kwargs)
        body = kwargs.merge(
          symbol: symbol,
          cell_number: cell_number,
          min_price: min_price,
          max_price: max_price,
          total_investment: total_investment
        )
        @session.sign_request(method: :post, path: '/v5/grid/validate-input', body: body)
      end
    end
  end
end
