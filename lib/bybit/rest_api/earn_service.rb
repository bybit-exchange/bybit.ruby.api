# frozen_string_literal: true

module Bybit
  module RestApi
    class EarnService < BaseService
      # Add Liquidity to a liquidity mining position.
      #
      # POST /v5/earn/liquidity-mining/add-liquidity
      #
      # @param product_id [String] Product ID
      # @param order_link_id [String] Client order id
      # @option kwargs [String] :quote_account_type Quote coin account type
      # @option kwargs [String] :base_account_type Base coin account type
      # @option kwargs [String] :quote_amount Quote coin amount
      # @option kwargs [String] :base_amount Base coin amount
      # @option kwargs [String] :leverage Leverage
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def add_liquidity(product_id:, order_link_id:, **kwargs)
        params = kwargs.merge(product_id: product_id, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/liquidity-mining/add-liquidity', body: params)
      end

      # Add Margin to a liquidity mining position.
      #
      # POST /v5/earn/liquidity-mining/add-margin
      #
      # @param product_id [String] Product ID
      # @param order_link_id [String] Client order id
      # @param position_id [String] Position ID
      # @param amount [String] Margin amount
      # @param quote_account_type [String] Quote coin account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def add_margin(product_id:, order_link_id:, position_id:, amount:, quote_account_type:, **kwargs)
        params = kwargs.merge(product_id: product_id, order_link_id: order_link_id, position_id: position_id, amount: amount, quote_account_type: quote_account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/liquidity-mining/add-margin', body: params)
      end

      # Claim Interest earned on liquidity mining product.
      #
      # POST /v5/earn/liquidity-mining/claim-interest
      #
      # @param product_id [String] Product ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def claim_liquidity_interest(product_id:, **kwargs)
        params = kwargs.merge(product_id: product_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/liquidity-mining/claim-interest', body: params)
      end

      # Get advance earn orders.
      #
      # GET /v5/earn/advance/order
      #
      # @param category [String] Product category
      # @option kwargs [Integer] :product_id Product ID
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User-defined order link ID
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Page size limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_advance_earn_order(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/advance/order', params: params)
      end

      # Get advance earn positions.
      #
      # GET /v5/earn/advance/position
      #
      # @param category [String] Product category
      # @option kwargs [Integer] :product_id Product ID
      # @option kwargs [String] :coin Coin
      # @option kwargs [Integer] :limit Page size limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_advance_earn_position(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/advance/position', params: params)
      end

      # Get advance earn product info.
      #
      # GET /v5/earn/advance/product
      #
      # @param category [String] Product category
      # @option kwargs [String] :coin Coin
      # @option kwargs [String] :duration Product duration
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_advance_earn_product(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/advance/product', params: params)
      end

      # Get advance earn product extra info.
      #
      # GET /v5/earn/advance/product-extra-info
      #
      # @param category [String] Product category
      # @option kwargs [Integer] :product_id Product ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_advance_earn_product_extra_info(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/advance/product-extra-info', params: params)
      end

      # Get double win leverage information.
      #
      # GET /v5/earn/advance/double-win-leverage
      #
      # @param product_id [Integer] Product ID
      # @param initial_price [String] Initial price
      # @param lower_price [String] Lower price bound
      # @param upper_price [String] Upper price bound
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_double_win_leverage(product_id:, initial_price:, lower_price:, upper_price:, **kwargs)
        params = kwargs.merge(product_id: product_id, initial_price: initial_price, lower_price: lower_price, upper_price: upper_price)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/advance/double-win-leverage', params: params)
      end

      # Get earn APR history.
      #
      # GET /v5/earn/apr-history
      #
      # @param category [String] Product category
      # @param product_id [String] Product ID
      # @param start_time [Integer] Start timestamp in milliseconds
      # @param end_time [Integer] End timestamp in milliseconds
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_apr_history(category:, product_id:, start_time:, end_time:, **kwargs)
        params = kwargs.merge(category: category, product_id: product_id, start_time: start_time, end_time: end_time)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/apr-history', params: params)
      end

      # Get earn hourly yield history.
      #
      # GET /v5/earn/hourly-yield
      #
      # @param category [String] Product category
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Page size limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_hourly_yield_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/hourly-yield', params: params)
      end

      # Get stake or redeem order history.
      #
      # GET /v5/earn/order
      #
      # @param category [String] Product category
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id User-defined order link ID
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Page size limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_order_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/order', params: params)
      end

      # Get staked positions.
      #
      # GET /v5/earn/position
      #
      # @param category [String] Product category
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [String] :coin Coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_position(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/position', params: params)
      end

      # Get earn product info.
      #
      # GET /v5/earn/product
      #
      # @param category [String] Product category
      # @option kwargs [String] :coin Coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_product(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/product', params: params)
      end

      # Get earn yield history.
      #
      # GET /v5/earn/yield
      #
      # @param category [String] Product category
      # @option kwargs [Integer] :product_id Product ID
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Page size limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_yield_history(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/yield', params: params)
      end

      # Get fixed-term earn order history.
      #
      # GET /v5/earn/fixed-term/order
      #
      # @option kwargs [String] :order_type Order type
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [String] :category Product category
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [Integer] :limit Result limit per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_term_order(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/fixed-term/order', params: params)
      end

      # Get fixed-term earn positions.
      #
      # GET /v5/earn/fixed-term/position
      #
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [String] :category Product category
      # @option kwargs [String] :coin Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_term_position(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/fixed-term/position', params: params)
      end

      # Get fixed-term earn product list.
      #
      # GET /v5/earn/fixed-term/product
      #
      # @option kwargs [String] :coin Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_term_product(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/fixed-term/product', params: params)
      end

      # Get Hold-to-Earn Product List.
      #
      # GET /v5/earn/hold-to-earn/product
      def get_hold_to_earn_product
        @session.public_request(path: '/v5/earn/hold-to-earn/product')
      end

      # Get Hold-to-Earn Yield History.
      #
      # GET /v5/earn/hold-to-earn/yield-history
      #
      # @param limit [Integer] Limit for data size per page
      # @option kwargs [Integer] :time_start Start time in ms
      # @option kwargs [Integer] :time_end End time in ms
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_hold_to_earn_yield_history(limit:, **kwargs)
        params = kwargs.merge(limit: limit)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/hold-to-earn/yield-history', params: params)
      end

      # Get liquidity mining liquidation records with optional filters and pagination.
      #
      # GET /v5/earn/liquidity-mining/liquidation-records
      #
      # @option kwargs [String] :base_coin Base coin filter
      # @option kwargs [String] :quote_coin Quote coin filter
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Result page size
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_liquidity_mining_liquidation_records(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/liquidity-mining/liquidation-records', params: params)
      end

      # Get Liquidity Mining Order History.
      #
      # GET /v5/earn/liquidity-mining/order
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id Client order id
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [String] :order_type Order type
      # @option kwargs [String] :status Order status
      # @option kwargs [Integer] :start_time Start time in ms
      # @option kwargs [Integer] :end_time End time in ms
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_liquidity_mining_orders(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/liquidity-mining/order', params: params)
      end

      # Get Liquidity Mining Active Positions.
      #
      # GET /v5/earn/liquidity-mining/position
      #
      # @option kwargs [String] :product_id Product ID
      # @option kwargs [String] :base_coin Base coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_liquidity_mining_positions(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/liquidity-mining/position', params: params)
      end

      # Get Liquidity Mining Product List.
      #
      # GET /v5/earn/liquidity-mining/product
      #
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :quote_coin Quote coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_liquidity_mining_products(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/liquidity-mining/product', params: params)
      end

      # Get Liquidity Mining Yield Claim Records.
      #
      # GET /v5/earn/liquidity-mining/yield-records
      #
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :quote_coin Quote coin
      # @option kwargs [Integer] :start_time Start time in ms
      # @option kwargs [Integer] :end_time End time in ms
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_liquidity_mining_yield_records(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/liquidity-mining/yield-records', params: params)
      end

      # Get RWA NAV Chart.
      #
      # GET /v5/earn/rwa/nav-chart
      #
      # @param product_id [Integer] Product ID
      # @option kwargs [Integer] :start_time Start time in ms
      # @option kwargs [Integer] :end_time End time in ms
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_rwa_nav_chart(product_id:, **kwargs)
        params = kwargs.merge(product_id: product_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/rwa/nav-chart', params: params)
      end

      # Get RWA Order List.
      #
      # GET /v5/earn/rwa/order
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_link_id Client order id
      # @option kwargs [String] :order_type Order type: Stake / Redeem
      # @option kwargs [Integer] :product_id Product ID
      # @option kwargs [Integer] :start_time Start time in ms
      # @option kwargs [Integer] :end_time End time in ms
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_rwa_order_list(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/rwa/order', params: params)
      end

      # Get RWA Position List.
      #
      # GET /v5/earn/rwa/position
      def get_rwa_position_list
        @session.sign_request(method: :get, path: '/v5/earn/rwa/position')
      end

      # Get RWA earn product list.
      #
      # GET /v5/earn/rwa/product
      #
      # @option kwargs [String] :coin Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_rwa_product_list(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/rwa/product', params: params)
      end

      # Get smart leverage redeem estimation amount list.
      #
      # GET /v5/earn/advance/get-redeem-est-amount-list
      #
      # @param category [String] Product category
      # @param position_ids [String] Position IDs
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_smart_leverage_redeem_est_amount_list(category:, position_ids:, **kwargs)
        params = kwargs.merge(category: category, position_ids: position_ids)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/advance/get-redeem-est-amount-list', params: params)
      end

      # Get daily yield records for a token earn position.
      #
      # GET /v5/earn/token/yield
      #
      # @param coin [String] Coin name
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [String] :cursor Cursor for pagination
      # @option kwargs [Integer] :limit Result limit per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_token_daily_yield(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/token/yield', params: params)
      end

      # Get historical APR for a token earn product.
      #
      # GET /v5/earn/token/history-apr
      #
      # @param coin [String] Coin name
      # @param range [Integer] Range window for APR history
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_token_historical_apr(coin:, range:, **kwargs)
        params = kwargs.merge(coin: coin, range: range)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/token/history-apr', params: params)
      end

      # Get hourly yield records for a token earn position.
      #
      # GET /v5/earn/token/hourly-yield
      #
      # @param coin [String] Coin name
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [String] :cursor Cursor for pagination
      # @option kwargs [Integer] :limit Result limit per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_token_hourly_yield(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/token/hourly-yield', params: params)
      end

      # Query token earn order history.
      #
      # GET /v5/earn/token/order
      #
      # @param coin [String] Coin name
      # @option kwargs [String] :order_link_id Client-supplied order link ID
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_type Order type (mint or redeem)
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [String] :cursor Cursor for pagination
      # @option kwargs [Integer] :limit Result limit per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_token_order_list(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/token/order', params: params)
      end

      # Get current token earn position for a coin.
      #
      # GET /v5/earn/token/position
      #
      # @param coin [String] Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_token_position(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/token/position', params: params)
      end

      # Get info for a token earn product.
      #
      # GET /v5/earn/token/product
      #
      # @param coin [String] Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_token_product(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/earn/token/product', params: params)
      end

      # List available earn coupons for the given category.
      #
      # GET /v5/earn/coupons
      #
      # @param category [String] Product category
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_coupons(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/coupons', params: params)
      end

      # Modify an earn position.
      #
      # POST /v5/earn/position/modify
      #
      # @param category [String] Product category
      # @param product_id [Integer] Product ID
      # @param position_id [Integer] Position ID
      # @param auto_reinvest [Integer] Auto-reinvest flag
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def modify_earn_position(category:, product_id:, position_id:, auto_reinvest:, **kwargs)
        params = kwargs.merge(category: category, product_id: product_id, position_id: position_id, auto_reinvest: auto_reinvest)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/position/modify', body: params)
      end

      # Place an advance earn order.
      #
      # POST /v5/earn/advance/place-order
      #
      # @param category [String] Product category
      # @param product_id [Integer] Product ID
      # @param order_type [String] Order type
      # @param amount [String] Order amount
      # @param account_type [String] Account type
      # @param coin [String] Coin
      # @param order_link_id [String] User-defined order link ID
      # @option kwargs [Hash] :dual_assets_extra Dual assets extra info
      # @option kwargs [Hash] :interest_card Interest card info
      # @option kwargs [Hash] :smart_leverage_stake_extra Smart leverage stake extra info
      # @option kwargs [Hash] :smart_leverage_redeem_extra Smart leverage redeem extra info
      # @option kwargs [Hash] :double_win_stake_extra Double win stake extra info
      # @option kwargs [Hash] :double_win_redeem_extra Double win redeem extra info
      # @option kwargs [Hash] :discount_buy_extra Discount buy extra info
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def place_advance_earn_order(category:, product_id:, order_type:, amount:, account_type:, coin:, order_link_id:, **kwargs)
        params = kwargs.merge(category: category, product_id: product_id, order_type: order_type, amount: amount, account_type: account_type, coin: coin, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/advance/place-order', body: params)
      end

      # Stake or redeem an earn order.
      #
      # POST /v5/earn/place-order
      #
      # @param category [String] Product category
      # @param order_type [String] Order type: Stake or Redeem
      # @param account_type [String] Account type
      # @param amount [String] Order amount
      # @param coin [String] Coin
      # @param product_id [String] Product ID
      # @param order_link_id [String] User-defined order link ID
      # @option kwargs [String] :redeem_position_id Redeem position ID
      # @option kwargs [String] :to_account_type Destination account type
      # @option kwargs [Hash] :interest_card Interest card info
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def place_order(category:, order_type:, account_type:, amount:, coin:, product_id:, order_link_id:, **kwargs)
        params = kwargs.merge(category: category, order_type: order_type, account_type: account_type, amount: amount, coin: coin, product_id: product_id, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/place-order', body: params)
      end

      # Place a fixed-term earn order.
      #
      # POST /v5/earn/fixed-term/place-order
      #
      # @param product_id [String] Product ID
      # @param category [String] Product category
      # @param coin [String] Coin name
      # @param amount [String] Order amount
      # @param account_type [String] Account type
      # @param order_link_id [String] Client-supplied order link ID
      # @option kwargs [Boolean] :auto_invest Whether to enable auto-invest
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def place_fixed_term_order(product_id:, category:, coin:, amount:, account_type:, order_link_id:, **kwargs)
        params = kwargs.merge(product_id: product_id, category: category, coin: coin, amount: amount, account_type: account_type, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/fixed-term/place-order', body: params)
      end

      # Place Order (Stake / Redeem) for RWA earn products.
      #
      # POST /v5/earn/rwa/place-order
      #
      # @param product_id [Integer] Product ID
      # @param order_type [String] Order type: Stake / Redeem
      # @param coin [String] Coin name
      # @param order_link_id [String] Client order id
      # @option kwargs [String] :stake_amount Stake amount, required when orderType is Stake
      # @option kwargs [String] :redeem_shares Redeem shares, required when orderType is Redeem
      # @option kwargs [String] :account_type Account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def place_rwa_order(product_id:, order_type:, coin:, order_link_id:, **kwargs)
        params = kwargs.merge(product_id: product_id, order_type: order_type, coin: coin, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/rwa/place-order', body: params)
      end

      # Place a mint or redeem order for a token earn product.
      #
      # POST /v5/earn/token/place-order
      #
      # @param coin [String] Coin name
      # @param order_link_id [String] Client-supplied order link ID
      # @param order_type [String] Order type (mint or redeem)
      # @param amount [String] Order amount
      # @param account_type [String] Account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def place_token_order(coin:, order_link_id:, order_type:, amount:, account_type:, **kwargs)
        params = kwargs.merge(coin: coin, order_link_id: order_link_id, order_type: order_type, amount: amount, account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/token/place-order', body: params)
      end

      # Get PWM investment plan asset trend over time.
      #
      # GET /v5/earn/pwm/investment-plan/asset-trend
      #
      # @param plan_id [String] Investment plan ID
      # @option kwargs [Integer] :start_time Start timestamp (ms)
      # @option kwargs [Integer] :end_time End timestamp (ms)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_asset_trend(plan_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/investment-plan/asset-trend', params: params)
      end

      # Claim available funds from a PWM investment plan.
      #
      # POST /v5/earn/pwm/investment-plan/claim
      #
      # @param plan_id [String] Investment plan ID
      # @param order_link_id [String] Client-generated unique order link ID
      # @option kwargs [String] :to_account_type Destination account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_claim(plan_id:, order_link_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/investment-plan/claim', body: params)
      end

      # Create a custom PWM investment plan in Direct Mode.
      #
      # POST /v5/earn/pwm/customize-plan/create
      #
      # @param products [Array] List of products to include in the plan
      # @param order_link_id [String] Client-generated unique order link ID
      # @option kwargs [String] :account_type Source account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_create_custom_plan(products:, order_link_id:, **kwargs)
        params = kwargs.merge(products: products, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/customize-plan/create', body: params)
      end

      # Get historical NAV data for a PWM fund.
      #
      # GET /v5/earn/pwm/investment-plan/fund-nav
      #
      # @param fund_id [String] Fund ID
      # @option kwargs [Integer] :start_time Start timestamp (ms)
      # @option kwargs [Integer] :end_time End timestamp (ms)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_fund_nav(fund_id:, **kwargs)
        params = kwargs.merge(fund_id: fund_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/investment-plan/fund-nav', params: params)
      end

      # Transfer funds between custody sub-accounts.
      #
      # POST /v5/earn/pwm/fund-transfer
      #
      # @param transfer_id [String] Client-supplied transfer identifier
      # @param from_user_id [Integer] Source sub-account UID
      # @param to_user_id [Integer] Destination sub-account UID
      # @param amount [String] Transfer amount
      # @param coin [String] Coin symbol
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_fund_transfer(transfer_id:, from_user_id:, to_user_id:, amount:, coin:, **kwargs)
        params = kwargs.merge(transfer_id: transfer_id, from_user_id: from_user_id, to_user_id: to_user_id, amount: amount, coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/fund-transfer', body: params)
      end

      # Get the detail of a pending-subscription investment plan.
      #
      # GET /v5/earn/pwm/investment-plan/new-plan
      #
      # @param plan_id [String] Investment plan identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_get_new_plan_detail(plan_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/investment-plan/new-plan', params: params)
      end

      # Get the detail of an active or closed investment plan.
      #
      # GET /v5/earn/pwm/investment-plan/detail
      #
      # @param plan_id [String] Investment plan identifier
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_get_plan_detail(plan_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/investment-plan/detail', params: params)
      end

      # Create a pending-subscription fund for the institution.
      #
      # POST /v5/earn/pwm/asset-manager/create-fund
      #
      # @param fund_name [String] Fund display name
      # @param coin [String] Base coin of the fund
      # @param profit_share_rate [String] Profit share rate
      # @param management_fee_rate [String] Management fee rate
      # @param req_link_id [String] Client-supplied idempotency key
      # @option kwargs [String] :fund_introduction Fund introduction text
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_create_fund(fund_name:, coin:, profit_share_rate:, management_fee_rate:, req_link_id:, **kwargs)
        params = kwargs.merge(fund_name: fund_name, coin: coin, profit_share_rate: profit_share_rate, management_fee_rate: management_fee_rate, req_link_id: req_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/asset-manager/create-fund', body: params)
      end

      # Create an investment plan for a client account.
      #
      # POST /v5/earn/pwm/asset-manager/create-investment-plan
      #
      # @param account_uid [String] Client account UID
      # @param plan_name [String] Investment plan name
      # @param plan_type [String] Investment plan type
      # @param investment_distribution [Array] Fund allocation distribution
      # @param req_link_id [String] Client-supplied idempotency key
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_create_investment_plan(account_uid:, plan_name:, plan_type:, investment_distribution:, req_link_id:, **kwargs)
        params = kwargs.merge(account_uid: account_uid, plan_name: plan_name, plan_type: plan_type, investment_distribution: investment_distribution, req_link_id: req_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/asset-manager/create-investment-plan', body: params)
      end

      # Create a fund custody sub-account.
      #
      # POST /v5/earn/pwm/asset-manager/create-sub-account
      #
      # @param fund_id [String] Fund identifier
      # @param req_link_id [String] Client-supplied idempotency key
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_create_sub_account(fund_id:, req_link_id:, **kwargs)
        params = kwargs.merge(fund_id: fund_id, req_link_id: req_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/asset-manager/create-sub-account', body: params)
      end

      # Query the institution's investment plans with optional filters.
      #
      # GET /v5/earn/pwm/asset-manager/get-investment-plan
      #
      # @option kwargs [String] :plan_id Investment plan identifier
      # @option kwargs [String] :status Plan status filter
      # @option kwargs [String] :subscription_uid Subscription account UID
      # @option kwargs [Integer] :limit Result page size
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_get_investment_plans(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/asset-manager/get-investment-plan', params: params)
      end

      # Query the institution's managed funds with optional filters.
      #
      # GET /v5/earn/pwm/asset-manager/all-funds
      #
      # @option kwargs [String] :fund_id Fund identifier
      # @option kwargs [String] :coin Coin filter
      # @option kwargs [String] :status Fund status filter
      # @option kwargs [Integer] :limit Result page size
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_list_funds(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/asset-manager/all-funds', params: params)
      end

      # Query fund subscription and redemption orders.
      #
      # GET /v5/earn/pwm/asset-manager/all-order
      #
      # @option kwargs [String] :fund_id Fund identifier
      # @option kwargs [String] :order_type Order type filter
      # @option kwargs [String] :status Order status filter
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Result page size
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_list_orders(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/asset-manager/all-order', params: params)
      end

      # Update the status and fund allocation of an investment plan.
      #
      # POST /v5/earn/pwm/asset-manager/manage-investment-plan
      #
      # @param plan_id [String] Investment plan identifier
      # @param req_link_id [String] Client-supplied idempotency key
      # @option kwargs [String] :update_status New plan status
      # @option kwargs [Array] :update_funds Updated fund allocation
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_manage_investment_plan(plan_id:, req_link_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id, req_link_id: req_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/asset-manager/manage-investment-plan', body: params)
      end

      # Approve or reject a fund subscription or redemption order.
      #
      # POST /v5/earn/pwm/asset-manager/manage-order
      #
      # @param order_id [String] Order identifier
      # @param action [String] Approve or reject action
      # @param req_link_id [String] Client-supplied idempotency key
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_manage_order(order_id:, action:, req_link_id:, **kwargs)
        params = kwargs.merge(order_id: order_id, action: action, req_link_id: req_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/asset-manager/manage-order', body: params)
      end

      # Execute profit settlement for the specified fund.
      #
      # POST /v5/earn/pwm/asset-manager/settle-profit
      #
      # @param fund_id [String] Fund identifier
      # @param req_link_id [String] Client-supplied idempotency key
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_inst_settle_profit(fund_id:, req_link_id:, **kwargs)
        params = kwargs.merge(fund_id: fund_id, req_link_id: req_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/asset-manager/settle-profit', body: params)
      end

      # Invest more funds into an active PWM investment plan.
      #
      # POST /v5/earn/pwm/investment-plan/invest-more
      #
      # @param plan_id [String] Investment plan ID
      # @param category [String] Product category
      # @param product_id [String] Product ID
      # @param amount [String] Investment amount
      # @param order_link_id [String] Client-generated unique order link ID
      # @option kwargs [String] :account_type Source account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_invest_more(plan_id:, category:, product_id:, amount:, order_link_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id, category: category, product_id: product_id, amount: amount, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/investment-plan/invest-more', body: params)
      end

      # List investment plans for the account.
      #
      # GET /v5/earn/pwm/investment-plan/all
      #
      # @option kwargs [String] :plan_id Investment plan identifier
      # @option kwargs [String] :status Plan status filter
      # @option kwargs [Integer] :limit Result page size
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_list_investment_plans(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/investment-plan/all', params: params)
      end

      # List PWM investment plan orders with optional filters.
      #
      # GET /v5/earn/pwm/investment-plan/order
      #
      # @option kwargs [String] :plan_id Investment plan ID
      # @option kwargs [String] :category Product category
      # @option kwargs [String] :type Order type
      # @option kwargs [String] :status Order status
      # @option kwargs [Integer] :start_time Start timestamp (ms)
      # @option kwargs [Integer] :end_time End timestamp (ms)
      # @option kwargs [Integer] :limit Result limit per page
      # @option kwargs [String] :cursor Pagination cursor
      # @option kwargs [String] :order_link_id Client order link ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_list_order(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/investment-plan/order', params: params)
      end

      # List available product cards for PWM Direct Mode custom plans.
      #
      # GET /v5/earn/pwm/customize-plan/product
      def pwm_list_product_cards
        @session.public_request(path: '/v5/earn/pwm/customize-plan/product')
      end

      # Query fund transfer records between custody sub-accounts.
      #
      # GET /v5/earn/pwm/query-fund-transfer-result
      #
      # @option kwargs [String] :transfer_id Client-supplied transfer identifier
      # @option kwargs [Integer] :from_user_id Source sub-account UID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_query_fund_transfer_result(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/earn/pwm/query-fund-transfer-result', params: params)
      end

      # Redeem shares or amount from a PWM investment plan.
      #
      # POST /v5/earn/pwm/investment-plan/redeem
      #
      # @param plan_id [String] Investment plan ID
      # @param category [String] Product category
      # @param product_id [String] Product ID
      # @param order_link_id [String] Client-generated unique order link ID
      # @option kwargs [String] :shares Number of shares to redeem
      # @option kwargs [String] :amount Amount to redeem
      # @option kwargs [Integer] :position_id Position ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_redeem(plan_id:, category:, product_id:, order_link_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id, category: category, product_id: product_id, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/investment-plan/redeem', body: params)
      end

      # One-click subscribe to a pending PWM investment plan.
      #
      # POST /v5/earn/pwm/investment-plan/subscribe
      #
      # @param plan_id [String] Investment plan ID
      # @param order_link_id [String] Client-generated unique order link ID
      # @option kwargs [String] :account_type Source account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def pwm_subscribe(plan_id:, order_link_id:, **kwargs)
        params = kwargs.merge(plan_id: plan_id, order_link_id: order_link_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/pwm/investment-plan/subscribe', body: params)
      end

      # Redeem a fixed-term earn position.
      #
      # POST /v5/earn/fixed-term/redeem
      #
      # @param product_id [String] Product ID
      # @param category [String] Product category
      # @param position_id [String] Position ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def redeem_fixed_term(product_id:, category:, position_id:, **kwargs)
        params = kwargs.merge(product_id: product_id, category: category, position_id: position_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/fixed-term/redeem', body: params)
      end

      # Reinvest Interest for a liquidity mining position.
      #
      # POST /v5/earn/liquidity-mining/reinvest
      #
      # @param product_id [String] Product ID
      # @param order_link_id [String] Client order id
      # @param position_id [String] Position ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def reinvest_liquidity(product_id:, order_link_id:, position_id:, **kwargs)
        params = kwargs.merge(product_id: product_id, order_link_id: order_link_id, position_id: position_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/liquidity-mining/reinvest', body: params)
      end

      # Remove Liquidity from a liquidity mining position.
      #
      # POST /v5/earn/liquidity-mining/remove-liquidity
      #
      # @param product_id [String] Product ID
      # @param order_link_id [String] Client order id
      # @param position_id [String] Position ID
      # @option kwargs [Integer] :remove_rate Remove rate percent
      # @option kwargs [String] :remove_type Remove type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def remove_liquidity(product_id:, order_link_id:, position_id:, **kwargs)
        params = kwargs.merge(product_id: product_id, order_link_id: order_link_id, position_id: position_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/liquidity-mining/remove-liquidity', body: params)
      end

      # Enable or disable auto-invest for a fixed-term earn position.
      #
      # POST /v5/earn/fixed-term/position/auto-invest
      #
      # @param product_id [String] Product ID
      # @param category [String] Product category
      # @param position_id [String] Position ID
      # @param status [String] Auto-invest status
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def set_fixed_term_auto_invest(product_id:, category:, position_id:, status:, **kwargs)
        params = kwargs.merge(product_id: product_id, category: category, position_id: position_id, status: status)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/earn/fixed-term/position/auto-invest', body: params)
      end
    end
  end
end
