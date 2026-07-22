# frozen_string_literal: true

module Bybit
  module RestApi
    class AccountService < BaseService
      # Batch Set Collateral
      #
      # POST /v5/account/set-collateral-switch-batch
      #
      # @param request [Array] Array of collateral switch objects
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/batch-set-collateral
      def batch_set_collateral(request:, **kwargs)
        params = kwargs.merge(request: request)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/set-collateral-switch-batch', body: params)
      end

      # Get Account Info
      #
      # GET /v5/account/info
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/account-info
      def get_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/info', params: params)
      end

      # Get Wallet Balance
      #
      # GET /v5/account/wallet-balance
      #
      # @param account_type [String] Account type: UNIFIED / CONTRACT / SPOT / FUND / OPTION.
      # @option kwargs [String] :coin Coin filter — comma-separated, e.g. "USDT,BTC".
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/wallet-balance
      def get_wallet_balance(account_type:, **kwargs)
        params = kwargs.merge(account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/wallet-balance', params: params)
      end

      # Get Account Instruments
      #
      # GET /v5/account/instruments-info
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor. Use the nextPageCursor token from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_instruments(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/instruments-info', params: params)
      end

      # Get Borrow History
      #
      # GET /v5/account/borrow-history
      #
      # @option kwargs [String] :currency USDC, USDT, BTC, ETH
      # @option kwargs [Integer] :start_time The start timestamp (ms)
      # @option kwargs [Integer] :end_time The end timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor. Use the nextPageCursor token from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/borrow-history
      def get_borrow_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/borrow-history', params: params)
      end

      # Get Collateral Info
      #
      # GET /v5/account/collateral-info
      #
      # @option kwargs [String] :currency Asset currency of all current collateral
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/collateral-info
      def get_collateral_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/collateral-info', params: params)
      end

      # Get DCP Info
      #
      # GET /v5/account/query-dcp-info
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/dcp-info
      def get_dcp_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/query-dcp-info', params: params)
      end

      # Get Fee Rate
      #
      # GET /v5/account/fee-rate
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin. SOL, BTC, ETH. Apply to option only
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/fee-rate
      def get_fee_rate(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/fee-rate', params: params)
      end

      # Get MMP State
      #
      # GET /v5/account/mmp-state
      #
      # @param base_coin [String] Base coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/get-mmp-state
      def get_mmp_state(base_coin:, **kwargs)
        params = kwargs.merge(base_coin: base_coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/mmp-state', params: params)
      end

      # Get SMP Group
      #
      # GET /v5/account/smp-group
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/smp-group
      def get_smp_group(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/smp-group', params: params)
      end

      # Get Transaction Log
      #
      # GET /v5/account/transaction-log
      #
      # @option kwargs [String] :account_type Account type. UNIFIED
      # @option kwargs [String] :category Product type
      # @option kwargs [String] :currency Currency
      # @option kwargs [String] :base_coin BaseCoin. e.g., BTC of BTCPERP
      # @option kwargs [String] :type Types of transaction logs
      # @option kwargs [String] :trans_sub_type Transaction subtype
      # @option kwargs [Integer] :start_time The start timestamp (ms)
      # @option kwargs [Integer] :end_time The end timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor. Use the nextPageCursor token from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/transaction-log
      def get_transaction_log(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/transaction-log', params: params)
      end

      # Get Transferable Amount
      #
      # GET /v5/account/withdrawal
      #
      # @param coin_name [String] Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_transferable_amount(coin_name:, **kwargs)
        params = kwargs.merge(coin_name: coin_name)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/withdrawal', params: params)
      end

      # Get User Settings
      #
      # GET /v5/account/user-setting-config
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_user_settings(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/account/user-setting-config', params: params)
      end

      # Manual Borrow
      #
      # POST /v5/account/borrow
      #
      # @param coin [String] Coin name
      # @param amount [String] The amount to borrow
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def manual_borrow(coin:, amount:, **kwargs)
        params = kwargs.merge(coin: coin, amount: amount)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/borrow', body: params)
      end

      # Manual Repay
      #
      # POST /v5/account/repay
      #
      # @option kwargs [String] :coin Coin name. If not passed, repay all liabilities
      # @option kwargs [String] :amount The amount to repay
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def manual_repay(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/repay', body: params)
      end

      # No-Convert Repay
      #
      # POST /v5/account/no-convert-repay
      #
      # @param coin [String] Coin name
      # @option kwargs [String] :amount The amount to repay
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/no-convert-repay
      def no_convert_repay(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/no-convert-repay', body: params)
      end

      # One-Click Repay: convert small balance coins to a specified coin to repay debt in one click.
      #
      # POST /v5/account/quick-repayment
      #
      # @option kwargs [String] :coin Coin to repay debt with
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def one_click_repay(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/quick-repayment', body: params)
      end

      # Reset MMP state for a given base coin.
      #
      # POST /v5/account/mmp-reset
      #
      # @param base_coin [String] Base coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def reset_mmp(base_coin:, **kwargs)
        params = kwargs.merge(base_coin: base_coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/mmp-reset', body: params)
      end

      # Enable or disable a coin as collateral for the unified account.
      #
      # POST /v5/account/set-collateral-switch
      #
      # @param coin [String] Coin symbol
      # @param collateral_switch [String] ON or OFF
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def set_collateral_coin(coin:, collateral_switch:, **kwargs)
        params = kwargs.merge(coin: coin, collateral_switch: collateral_switch)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/set-collateral-switch', body: params)
      end

      # Set margin mode for the unified account (ISOLATED_MARGIN, REGULAR_MARGIN, PORTFOLIO_MARGIN).
      #
      # POST /v5/account/set-margin-mode
      #
      # @param set_margin_mode [String] Margin mode to set
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/set-margin-mode
      def set_margin_mode(set_margin_mode:, **kwargs)
        params = kwargs.merge(set_margin_mode: set_margin_mode)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/set-margin-mode', body: params)
      end

      # Configure Market Maker Protection parameters for a base coin.
      #
      # POST /v5/account/mmp-modify
      #
      # @param base_coin [String] Base coin
      # @param window [String] Time window (ms)
      # @param frozen_period [String] Frozen period (ms)
      # @param qty_limit [String] Quantity limit
      # @param delta_limit [String] Delta limit
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/set-mmp
      def set_mmp(base_coin:, window:, frozen_period:, qty_limit:, delta_limit:, **kwargs)
        params = kwargs.merge(base_coin: base_coin, window: window, frozen_period: frozen_period, qty_limit: qty_limit, delta_limit: delta_limit)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/mmp-modify', body: params)
      end

      # Toggle whether the price limit rule applies to modify order actions for a category.
      #
      # POST /v5/account/set-limit-px-action
      #
      # @param category [String] Product type
      # @param modify_enable [Boolean] Enable modify price limit check
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def set_price_limit(category:, modify_enable:, **kwargs)
        params = kwargs.merge(category: category, modify_enable: modify_enable)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/set-limit-px-action', body: params)
      end

      # Enable or disable spot hedging mode for the unified account.
      #
      # POST /v5/account/set-hedging-mode
      #
      # @param set_hedging_mode [String] ON or OFF
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/set-spot-hedge
      def set_spot_hedging(set_hedging_mode:, **kwargs)
        params = kwargs.merge(set_hedging_mode: set_hedging_mode)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/set-hedging-mode', body: params)
      end

      # Upgrade the current account to Unified Trading Account (UTA) Pro.
      #
      # POST /v5/account/upgrade-to-uta
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/account/upgrade-unified-account
      def upgrade_to_uta_pro(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/account/upgrade-to-uta', body: params)
      end
    end
  end
end
