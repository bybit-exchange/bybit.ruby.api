# frozen_string_literal: true

module Bybit
  module RestApi
    class SpotMarginService < BaseService
      # Get historical interest rate for spot margin trading.
      #
      # GET /v5/spot-margin-trade/interest-rate-history
      #
      # @param currency [String] Currency
      # @option kwargs [String] :vip_level VIP level
      # @option kwargs [Integer] :start_time Start time in milliseconds
      # @option kwargs [Integer] :end_time End time in milliseconds
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-uta/historical-interest
      def get_historical_interest_rate(currency:, **kwargs)
        params = kwargs.merge(currency: currency)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/interest-rate-history', params: params)
      end

      # Get spot margin position tiers.
      #
      # GET /v5/spot-margin-trade/position-tiers
      #
      # @option kwargs [String] :currency Currency
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-uta/position-tiers
      def get_position_tiers(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/position-tiers', params: params)
      end

      # Get tiered collateral ratio for spot margin trading.
      #
      # GET /v5/spot-margin-trade/collateral
      #
      # @option kwargs [String] :currency Currency
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_tiered_collateral_ratio(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/spot-margin-trade/collateral', params: params)
      end

      # Get VIP margin data for spot margin trading.
      #
      # GET /v5/spot-margin-trade/data
      #
      # @option kwargs [String] :vip_level VIP level
      # @option kwargs [String] :currency Currency
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-uta/vip-margin
      def get_vip_margin_data(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/spot-margin-trade/data', params: params)
      end

      # Get Spot Margin Coin State
      #
      # GET /v5/spot-margin-trade/coinstate
      #
      # @option kwargs [String] :currency Coin name, uppercase only. e.g. `BTC`. If not passed, returns all coin states.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/coinstate
      def get_trade_coin_state(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/coinstate', params: params)
      end

      # Query Fixed-Rate Available Inventory
      #
      # GET /v5/spot-margin-trade/fixed-available-inventory
      #
      # @param currency [String] Borrow coin name, uppercase only. e.g. `USDT`, `BTC`. **Required.**
      # @param term [String] Loan term in days. e.g. `7`, `14`, `30`, `90`, `180`. **Required.**
      # @param annual_rate [String] Annual interest rate. e.g. `0.02` means 2%. **Required.**
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/fixed-available-inventory
      def query_fixed_available_inventory(currency:, term:, annual_rate:)
        params = Bybit::Utils::WireKeys.camelize({ currency: currency, term: term, annualRate: annual_rate })
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/fixed-available-inventory', params: params)
      end

      # Fixed-Rate Borrow
      #
      # POST /v5/spot-margin-trade/fixedborrow
      #
      # @param order_currency [String] Borrow coin name, uppercase only. e.g. `USDT`, `BTC`.
      # @param order_amount [String] Borrow amount.
      # @param annual_rate [String] Annual interest rate. e.g. `0.02` means 2%.
      # @param term [String] Loan term in days. Supported values: `7`, `14`, `30`, `90`, `180`.
      # @option kwargs [String] :repay_type Maturity handling type.
      #   - `1`: Auto-repay at maturity (default)
      #   - `2`: Convert to flexible-rate (variable-rate) loan at maturity
      # @option kwargs [String] :strategy_type Order strategy.
      #   - `PARTIAL`: Partial fill or cancel (immediate-or-cancel)
      #   - `FULL`: Fill or kill (all-or-nothing)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/fixedborrow
      def account_fixed_borrow(order_currency:, order_amount:, annual_rate:, term:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(orderCurrency: order_currency, orderAmount: order_amount, annualRate: annual_rate, term: term))
        @session.sign_request(method: :post, path: '/v5/spot-margin-trade/fixedborrow', body: params)
      end

      # Query Fixed-Rate Borrow Contracts
      #
      # GET /v5/spot-margin-trade/fixedborrow-contract-info
      #
      # @option kwargs [String] :order_id Filter by borrow order ID.
      # @option kwargs [String] :order_currency Filter by borrow coin name, uppercase only. e.g. `USDT`.
      # @option kwargs [String] :term Filter by loan term in days. e.g. `7`, `14`, `30`, `90`, `180`.
      # @option kwargs [String] :limit Page size. Range: [1, 100]. Default: `10`.
      # @option kwargs [String] :cursor Cursor for pagination. Use `nextPageCursor` from previous response.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/fixedborrow-contract-info
      def query_fixed_borrow_contracts(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/fixedborrow-contract-info', params: params)
      end

      # Query Fixed-Rate Borrow Orders
      #
      # GET /v5/spot-margin-trade/fixedborrow-order-info
      #
      # @option kwargs [String] :order_id Filter by borrow order ID.
      # @option kwargs [String] :order_currency Filter by borrow coin name, uppercase only. e.g. `USDT`.
      # @option kwargs [String] :state Filter by order state.
      #   - `1`: Matching (order accepted, matching in progress)
      #   - `2`: Partially filled & cancelled
      #   - `3`: Fully filled
      #   - `4`: Cancelled
      # @option kwargs [String] :term Filter by loan term in days. e.g. `7`, `14`, `30`, `90`, `180`.
      # @option kwargs [String] :limit Page size. Range: [1, 100]. Default: `10`.
      # @option kwargs [String] :cursor Cursor for pagination. Use `nextPageCursor` from previous response.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/fixedborrow-order-info
      def query_fixed_borrow_orders(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/fixedborrow-order-info', params: params)
      end

      # Query Fixed-Rate Borrow Market
      #
      # GET /v5/spot-margin-trade/fixedborrow-order-quote
      #
      # @param order_currency [String] Borrow coin name, uppercase only. e.g. `USDT`, `BTC`. **Required.**
      # @param order_by [String] Sort field. **Required.**
      #   - `apy`: Sort by annual interest rate
      #   - `term`: Sort by loan term
      #   - `quantity`: Sort by available quantity
      # @option kwargs [String] :term Filter by loan term in days. e.g. `7`, `14`, `30`, `90`, `180`.
      # @option kwargs [Integer] :sort Sort order.
      #   - `0`: Ascending (default)
      #   - `1`: Descending
      # @option kwargs [Integer] :limit Page size. Range: [1, 100]. Default: `10`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/fixedborrow-order-quote
      def query_fixed_borrow_market(order_currency:, order_by:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(orderCurrency: order_currency, orderBy: order_by))
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/fixedborrow-order-quote', params: params)
      end

      # Renew Fixed-Rate Borrow
      #
      # POST /v5/spot-margin-trade/fixedborrow-renew
      #
      # @param loan_id [String] The loan contract ID (corresponds to match order ID). Required.
      # @option kwargs [String] :qty Renewal amount.
      #   - If not provided, the full prepayment amount of the contract is used
      #   - Must be greater than 0
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/fixedborrow-renew
      def renew_fixed_borrow(loan_id:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(loanId: loan_id))
        @session.sign_request(method: :post, path: '/v5/spot-margin-trade/fixedborrow-renew', body: params)
      end

      # Get Flexible Available Inventory
      #
      # GET /v5/spot-margin-trade/flexible-available-inventory
      #
      # @param currency [String] Coin name, uppercase only. e.g. `BTC`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/flexible-available-inventory
      def get_trade_flexible_available_inventory(currency:)
        params = Bybit::Utils::WireKeys.camelize({ currency: currency })
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/flexible-available-inventory', params: params)
      end

      # Get Auto Repay Mode
      #
      # GET /v5/spot-margin-trade/get-auto-repay-mode
      #
      # @option kwargs [String] :currency Coin name, uppercase only. e.g. `ETH`. When omitted, returns settings for all currencies.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/get-auto-repay-mode
      def get_trade_auto_repay_mode(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/get-auto-repay-mode', params: params)
      end

      # Query Borrow Liability
      #
      # GET /v5/spot-margin-trade/liability
      #
      # @param currency [String] Coin name, uppercase only. e.g. `USDT`, `BTC`. **Required.**
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/liability
      def query_borrow_liability(currency:)
        params = Bybit::Utils::WireKeys.camelize({ currency: currency })
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/liability', params: params)
      end

      # Get Max Borrowable Amount
      #
      # GET /v5/spot-margin-trade/max-borrowable
      #
      # @param currency [String] Coin name, uppercase only. e.g. `BTC`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/max-borrowable
      def get_trade_max_borrowable(currency:)
        params = Bybit::Utils::WireKeys.camelize({ currency: currency })
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/max-borrowable', params: params)
      end

      # Get Repayment Available Amount
      #
      # GET /v5/spot-margin-trade/repayment-available-amount
      #
      # @param currency [String] Coin name, uppercase only. e.g. `BTC`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/repayment-available-amount
      def get_trade_repayment_available_amount(currency:)
        params = Bybit::Utils::WireKeys.camelize({ currency: currency })
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/repayment-available-amount', params: params)
      end

      # Set Auto Repay Mode
      #
      # POST /v5/spot-margin-trade/set-auto-repay-mode
      #
      # @param auto_repay_mode [String] Auto repay mode switch:
      #   - `1`: Enable auto repay — Enable auto repay
      #   - `0`: Disable auto repay — Disable auto repay
      # @option kwargs [String] :currency Coin name, uppercase only (e.g. `USDT`, `ETH`).
      #   If omitted, auto-repay is enabled/disabled for **all** currencies.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/set-auto-repay-mode
      def set_auto_repay_mode(auto_repay_mode:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(autoRepayMode: auto_repay_mode))
        @session.sign_request(method: :post, path: '/v5/spot-margin-trade/set-auto-repay-mode', body: params)
      end

      # Set spot cross margin leverage
      #
      # POST /v5/spot-margin-trade/set-leverage
      #
      # @param leverage [String] Leverage amount, valid range is 2 to 10
      # @option kwargs [String] :currency Coin name, uppercase only (optional)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/set-leverage
      def spot_margin_set_leverage(leverage:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(leverage: leverage))
        @session.sign_request(method: :post, path: '/v5/spot-margin-trade/set-leverage', body: params)
      end

      # Get Spot Margin Trade Status
      #
      # GET /v5/spot-margin-trade/state
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/state
      def get_trade_state
        @session.sign_request(method: :get, path: '/v5/spot-margin-trade/state')
      end

      # Toggle spot cross margin mode
      #
      # POST /v5/spot-margin-trade/switch-mode
      #
      # @param spot_margin_mode [String] Spot margin mode: 1=on, 0=off
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-trade/switch-mode
      def spot_margin_switch_mode(spot_margin_mode:)
        params = Bybit::Utils::WireKeys.camelize({ spotMarginMode: spot_margin_mode })
        @session.sign_request(method: :post, path: '/v5/spot-margin-trade/switch-mode', body: params)
      end
    end
  end
end
