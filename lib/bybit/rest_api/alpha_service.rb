# frozen_string_literal: true

module Bybit
  module RestApi
    class AlphaService < BaseService
      # Get LP order history with status and execution details
      #
      # POST /v5/alpha/lp/order-list
      #
      # @option kwargs [Integer] :order_type Filter by order type.
      #   - `0`: All (default)
      #   - `1`: Stake
      #   - `2`: Redeem
      # @option kwargs [String] :token_code Filter by token code.
      # @option kwargs [Array] :order_status Filter by order status (multiple values allowed).
      #   - `1`: Processing
      #   - `2`: Success
      #   - `3`: Failed
      # @option kwargs [Integer] :days Query last N days.
      # @option kwargs [Integer] :limit Results per page.
      # @option kwargs [Integer] :page_index Page number (1-based).
      # @option kwargs [String] :pool_address Filter by pool address.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/order-list
      def get_lp_order_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/lp/order-list', body: params)
      end

      # Get list of supported payment tokens
      #
      # POST /v5/alpha/lp/pay-token-list
      #
      # @option kwargs [String] :chain_code Optional - filter by blockchain identifier.
      # @option kwargs [String] :token_address Optional - filter by token contract address.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/pay-token-list
      def get_lp_pay_token_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/lp/pay-token-list', body: params)
      end

      # Get current prices for payment tokens
      #
      # POST /v5/alpha/lp/pay-token-price
      #
      # @param token_code [Array] Array of token codes to query (e.g., ["CEX_1", "CEX_2"]).
      # @option kwargs [String] :chain_code Optional - filter by blockchain.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/pay-token-price
      def get_lp_pay_token_price(token_code:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(tokenCode: token_code))
        @session.sign_request(method: :post, path: '/v5/alpha/lp/pay-token-price', body: params)
      end

      # Get detailed information for a specific LP pool
      #
      # POST /v5/alpha/lp/pool-info
      #
      # @param pool_address [String] Pool contract address (from getLPPoolList).
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/pool-info
      def get_lp_pool_info(pool_address:)
        params = Bybit::Utils::WireKeys.camelize({ poolAddress: pool_address })
        @session.sign_request(method: :post, path: '/v5/alpha/lp/pool-info', body: params)
      end

      # Get LP pool list with optional filters
      #
      # POST /v5/alpha/lp/pool-list
      #
      # @option kwargs [String] :token_symbol Search pools containing this token symbol (e.g., "ETH", "USDC").
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/pool-list
      def get_lp_pool_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/lp/pool-list', body: params)
      end

      # Get user's LP positions with rewards and current value
      #
      # POST /v5/alpha/lp/position-list
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/position-list
      def get_lp_position_list
        @session.sign_request(method: :post, path: '/v5/alpha/lp/position-list')
      end

      # Redeem (withdraw) liquidity from a position
      #
      # POST /v5/alpha/lp/redeem
      #
      # @param position_id [Integer] Position ID (from getLPPositionList).
      # @param pool_address [String] Pool contract address.
      # @param derc_ratio [String] Reduction ratio (0-1).
      #   - "0.25" = redeem 25%
      #   - "0.5" = redeem 50%
      #   - "1" = close entire position (redeem 100%)
      # @option kwargs [String] :receive_token_code Token code for receiving the redeemed amount.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/redeem
      def execute_lp_redeem(position_id:, pool_address:, derc_ratio:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(positionId: position_id, poolAddress: pool_address, dercRatio: derc_ratio))
        @session.sign_request(method: :post, path: '/v5/alpha/lp/redeem', body: params)
      end

      # Stake tokens into an LP pool
      #
      # POST /v5/alpha/lp/stake
      #
      # @param position_id [Integer] Position ID. Use `0` to create a new position, or provide an existing position ID to add liquidity.
      # @param pool_address [String] Pool contract address (from getLPPoolInfo).
      # @param pay_token_amount [String] Payment token amount (positive decimal as string).
      # @param pay_token_code [String] Payment token code (e.g., "CEX_1" for USDT).
      # @option kwargs [String] :range_upper Range order - upper limit. Use this OR priceUpper, not both.
      # @option kwargs [String] :range_lower Range order - lower limit. Use this OR priceLower, not both.
      # @option kwargs [String] :price_upper Price order - upper limit (price priority). Use this OR rangeUpper, not both.
      # @option kwargs [String] :price_lower Price order - lower limit (price priority). Use this OR rangeLower, not both.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/lp/stake
      def execute_lp_stake(position_id:, pool_address:, pay_token_amount:, pay_token_code:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(positionId: position_id, poolAddress: pool_address, payTokenAmount: pay_token_amount, payTokenCode: pay_token_code))
        @session.sign_request(method: :post, path: '/v5/alpha/lp/stake', body: params)
      end

      # Buy prediction outcome tokens with USDC
      #
      # POST /v5/alpha/prediction/buy
      #
      # @param token_id [String] Outcome token ID to buy (from getPredictionEventDetail).
      # @param amount [String] USDC amount to invest (positive decimal as string).
      # @param pay_token_code [String] Payment token code. Phase 1 fixed to "USDC".
      # @param order_type [String]
      # @param slippage [String] Maximum acceptable price slippage as decimal (e.g., "0.05" = 5% tolerance).
      # @param event_id [String] Event ID associated with the token.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/buy
      def execute_prediction_buy(token_id:, amount:, pay_token_code:, order_type:, slippage:, event_id:)
        params = Bybit::Utils::WireKeys.camelize({ tokenId: token_id, amount: amount, payTokenCode: pay_token_code, orderType: order_type, slippage: slippage, eventId: event_id })
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/buy', body: params)
      end

      # Get prediction market matching engine availability status
      #
      # GET /v5/alpha/prediction/engine-status
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/engine-status
      def get_prediction_engine_status
        @session.sign_request(method: :get, path: '/v5/alpha/prediction/engine-status')
      end

      # Get prediction event detail with all markets and outcomes
      #
      # POST /v5/alpha/prediction/event-detail
      #
      # @option kwargs [String] :event_id Event ID. Use slug when available (takes priority).
      # @option kwargs [String] :slug URL-friendly event slug. Takes priority over eventId when both provided.
      # @option kwargs [Boolean] :has_more_markets Whether to merge markets from related sub-events. Default false.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/event-detail
      def get_prediction_event_detail(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/event-detail', body: params)
      end

      # Get full order book snapshot for prediction tokens
      #
      # POST /v5/alpha/prediction/order-book
      #
      # @param token_ids [Array] List of outcome token IDs. Maximum 20.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/order-book
      def get_prediction_order_book(token_ids:)
        params = Bybit::Utils::WireKeys.camelize({ tokenIds: token_ids })
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/order-book', body: params)
      end

      # Estimate buy or sell order fill amount and fees before execution
      #
      # POST /v5/alpha/prediction/order-estimate
      #
      # @param token_id [String] Outcome token ID (from getPredictionEventDetail or getPredictionMarketList).
      # @param side [String]
      # @param event_id [String] Event ID associated with this token.
      # @param amount [String] For BUY: USDC amount to invest (e.g., "100").
      #   For SELL: number of shares to sell (e.g., "50").
      # @param order_type [String]
      # @option kwargs [String] :pay_token_code Payment token code. Required for BUY. Phase 1 fixed to "USDC".
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/order-estimate
      def get_prediction_order_estimate(token_id:, side:, event_id:, amount:, order_type:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(tokenId: token_id, side: side, eventId: event_id, amount: amount, orderType: order_type))
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/order-estimate', body: params)
      end

      # Get user's prediction market order history
      #
      # POST /v5/alpha/prediction/order-list
      #
      # @option kwargs [String] :status
      # @option kwargs [String] :token_id Optional. Filter by specific outcome token ID.
      # @option kwargs [Integer] :limit Number of records per page.
      # @option kwargs [Integer] :page_index Page number starting from 1.
      # @option kwargs [String] :event_id Optional. Filter by event ID.
      # @option kwargs [String] :side
      # @option kwargs [Integer] :days Look back N days. Maximum 90.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/order-list
      def get_prediction_order_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/order-list', body: params)
      end

      # Get available payment tokens (USDC) for prediction market
      #
      # GET /v5/alpha/prediction/pay-token-list
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/pay-token-list
      def get_prediction_pay_token_list
        @session.sign_request(method: :get, path: '/v5/alpha/prediction/pay-token-list')
      end

      # Get user's prediction market portfolio overview
      #
      # POST /v5/alpha/prediction/portfolio-summary
      #
      # @option kwargs [Integer] :event_type Optional sports event type filter.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/portfolio-summary
      def get_prediction_portfolio_summary(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/portfolio-summary', body: params)
      end

      # Get user's historical closed prediction market positions
      #
      # POST /v5/alpha/prediction/position-history
      #
      # @option kwargs [Integer] :limit Number of records per page.
      # @option kwargs [Integer] :page_index Page number starting from 1.
      # @option kwargs [String] :direction Pagination cursor direction.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/position-history
      def get_prediction_position_history(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/position-history', body: params)
      end

      # Get user's current open prediction market positions
      #
      # POST /v5/alpha/prediction/position-list
      #
      # @option kwargs [Integer] :limit Number of records per page.
      # @option kwargs [Integer] :page_index Page number starting from 1.
      # @option kwargs [String] :direction Pagination cursor direction.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/position-list
      def get_prediction_position_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/position-list', body: params)
      end

      # Get historical price chart data for prediction tokens
      #
      # POST /v5/alpha/prediction/price-history
      #
      # @param token_id [String] Outcome token ID.
      # @param interval [String] Price history interval.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/price-history
      def get_prediction_price_history(token_id:, interval:)
        params = Bybit::Utils::WireKeys.camelize(tokenId: token_id, interval: interval)
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/price-history', body: params)
      end

      # Sell prediction outcome token shares for USDC
      #
      # POST /v5/alpha/prediction/sell
      #
      # @param token_id [String] Outcome token ID to sell (from getPredictionPositionList).
      # @param size [String] Number of shares to sell (positive decimal as string).
      # @param order_type [String]
      # @param slippage [String] Maximum acceptable price slippage as decimal (e.g., "0.05" = 5% tolerance).
      # @param event_id [String] Event ID associated with the token.
      # @option kwargs [String] :to_token_code Destination token code. Phase 1 fixed to "USDC".
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/sell
      def execute_prediction_sell(token_id:, size:, order_type:, slippage:, event_id:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(tokenId: token_id, size: size, orderType: order_type, slippage: slippage, eventId: event_id))
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/sell', body: params)
      end

      # Get related side markets for a sports event
      #
      # POST /v5/alpha/prediction/side-market-list
      #
      # @param event_id [String] Event ID to query markets for.
      # @option kwargs [String] :sort_by Sort by volume, liquidity, or endDate.
      # @option kwargs [Integer] :market_type Filter by market type.
      # @option kwargs [Integer] :limit Number of records per page.
      # @option kwargs [Integer] :page_index Page number starting from 1.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/side-market-list
      def get_prediction_side_market_list(event_id:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(eventId: event_id))
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/side-market-list', body: params)
      end

      # Get group standings and results for a tournament stage
      #
      # POST /v5/alpha/prediction/sports/group-stage-detail
      #
      # @param event_type [Integer] Sports event type. `1` = FIFA_2026.
      # @option kwargs [String] :group_name Optional group name filter.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/sports-group-stage-detail
      def get_prediction_group_stage_detail(event_type:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(eventType: event_type))
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/sports/group-stage-detail', body: params)
      end

      # Get match list for a sports prediction event
      #
      # POST /v5/alpha/prediction/sports/match-list
      #
      # @param event_type [Integer] Sports event type. `1` = FIFA_2026.
      # @option kwargs [Integer] :status Optional match status filter.
      # @option kwargs [Integer] :start_time Optional start timestamp in milliseconds.
      # @option kwargs [Integer] :end_time Optional end timestamp in milliseconds.
      # @option kwargs [String] :stage_code Optional tournament stage code.
      # @option kwargs [Integer] :limit Number of records per page.
      # @option kwargs [Integer] :page_index Page number starting from 1.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/sports-match-list
      def get_prediction_match_list(event_type:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(eventType: event_type))
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/sports/match-list', body: params)
      end

      # Get tournament timeline stages for a sports event
      #
      # GET /v5/alpha/prediction/sports/timeline-stages
      #
      # @param event_type [Integer] Sports event type. `1` = FIFA_2026.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/sports-timeline-stages
      def get_prediction_timeline_stages(event_type:)
        params = Bybit::Utils::WireKeys.camelize(eventType: event_type)
        @session.sign_request(method: :get, path: '/v5/alpha/prediction/sports/timeline-stages', params: params)
      end

      # Get real-time prices for prediction outcome tokens
      #
      # POST /v5/alpha/prediction/token-price
      #
      # @param token_ids [Array] List of outcome token IDs to query. Maximum 20.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/prediction/token-price
      def get_prediction_token_price(token_ids:)
        params = Bybit::Utils::WireKeys.camelize({ tokenIds: token_ids })
        @session.sign_request(method: :post, path: '/v5/alpha/prediction/token-price', body: params)
      end

      # Get holding details for a specific token including quantity, PnL, and cost basis
      #
      # POST /v5/alpha/trade/asset-detail
      #
      # @param chain_code [String] Blockchain code (ETH, SOL, BSC, etc.).
      # @param token_address [String] Token contract address on chain.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/asset-detail
      def get_asset_detail(chain_code:, token_address:)
        params = Bybit::Utils::WireKeys.camelize({ chainCode: chain_code, tokenAddress: token_address })
        @session.sign_request(method: :post, path: '/v5/alpha/trade/asset-detail', body: params)
      end

      # Get user's on-chain token portfolio with holdings, PnL, and market value
      #
      # POST /v5/alpha/trade/asset-list
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/asset-list
      def get_asset_list
        @session.sign_request(method: :post, path: '/v5/alpha/trade/asset-list')
      end

      # Get token project details including description, social links, risk flag, and order limits
      #
      # POST /v5/alpha/trade/biz-token-details
      #
      # @param chain_code [String] Blockchain code (ETH, SOL, BSC, etc.).
      # @param token_address [String] Token contract address on chain.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/biz-token-details
      def get_biz_token_details(chain_code:, token_address:)
        params = Bybit::Utils::WireKeys.camelize({ chainCode: chain_code, tokenAddress: token_address })
        @session.sign_request(method: :post, path: '/v5/alpha/trade/biz-token-details', body: params)
      end

      # Get on-chain tradable tokens with DEX token codes, risk flags, and order limits
      #
      # POST /v5/alpha/trade/biz-token-list
      #
      # @option kwargs [Integer] :token_tag Token tag filter.
      #   - `0`: All (no filter, default)
      #   - `1`: New token sniping
      #   - `2`: On-chain hot token
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/biz-token-list
      def get_biz_token_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/trade/biz-token-list', body: params)
      end

      # Batch query token prices, 24h change, volume, market cap, liquidity, and holders by chain+address
      #
      # POST /v5/alpha/trade/biz-token-price-list
      #
      # @param token_address_info [Array] List of token identifiers to query. Maximum 20 items per request.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/biz-token-price-list
      def get_biz_token_price_list(token_address_info:)
        params = Bybit::Utils::WireKeys.camelize({ tokenAddressInfo: token_address_info })
        @session.sign_request(method: :post, path: '/v5/alpha/trade/biz-token-price-list', body: params)
      end

      # Get trade order history with status, fees, and execution details
      #
      # POST /v5/alpha/trade/order-list
      #
      # @option kwargs [Integer] :trade_type Filter by trade type.
      #   - `0`: All (default)
      #   - `1`: Purchase (buy)
      #   - `2`: Redeem (sell)
      # @option kwargs [String] :token_code Filter by token code.
      # @option kwargs [Array] :order_status Filter by order status (multiple values allowed).
      #   - `1`: Processing
      #   - `2`: Success
      #   - `3`: Failed
      # @option kwargs [Integer] :days Query last N days. Maximum 90. `0` means use system default (90 days).
      # @option kwargs [Integer] :limit Results per page.
      # @option kwargs [Integer] :page_index Page number (1-based).
      # @option kwargs [String] :direction Pagination direction.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/order-list
      def get_order_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/alpha/trade/order-list', body: params)
      end

      # Get available payment tokens (USDT, USDC, etc.) with CEX token codes and supported chains
      #
      # POST /v5/alpha/trade/pay-token-list
      #
      # @param chain_code [String] Blockchain code (e.g. SOL, MANTLE).
      # @param token_address [String] Token contract address on chain.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/pay-token-list
      def get_pay_token_list(chain_code:, token_address:)
        params = Bybit::Utils::WireKeys.camelize({ chainCode: chain_code, tokenAddress: token_address })
        @session.sign_request(method: :post, path: '/v5/alpha/trade/pay-token-list', body: params)
      end

      # Execute a buy order to purchase on-chain tokens with USDT/USDC, returns order number
      #
      # POST /v5/alpha/trade/purchase
      #
      # @param from_token_code [String] Payment token code (`CEX_<id>`, e.g. `CEX_1` for USDT). Must match the quote request.
      # @param from_token_amount [String] Payment amount (positive decimal as string). Must match the quote request.
      # @param to_token_code [String] Target on-chain token code (`DEX_<id>`). Must match the quote request.
      # @param slippage [String] Slippage tolerance as decimal.
      #   - `0.005` = 0.5%
      #   - `0.01` = 1%
      #   - `0.05` = 5%
      # @param quote_data [String] Base64-encoded quote data. **Must pass as-is from `/quote` response.**
      # @param gas [String] Estimated gas fee. **Must pass as-is from `/quote` response.**
      # @param quote_mode [Integer] Quote mode. Must be consistent with the `/quote` request.
      #   - `0`: Auto
      #   - `1`: Price Priority
      #   - `2`: Success Rate Priority
      # @param correcting_code [String] MD5 checksum for data integrity. **Must pass as-is from `/quote` response.**
      # @option kwargs [String] :tenant Optional tenant identifier.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/trade-purchase
      def execute_purchase(from_token_code:, from_token_amount:, to_token_code:, slippage:, quote_data:, gas:, quote_mode:, correcting_code:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(fromTokenCode: from_token_code, fromTokenAmount: from_token_amount, toTokenCode: to_token_code, slippage: slippage, quoteData: quote_data, gas: gas, quoteMode: quote_mode, correctingCode: correcting_code))
        @session.sign_request(method: :post, path: '/v5/alpha/trade/purchase', body: params)
      end

      # Get estimated price, fees, slippage, and gas for an on-chain token trade
      #
      # POST /v5/alpha/trade/quote
      #
      # @param trade_type [Integer] Trade type.
      #   - `1`: Purchase (buy on-chain token with payment token)
      #   - `2`: Redeem (sell on-chain token for payment token)
      # @param from_token_code [String] Source token code. Format: `CEX_<id>` or `DEX_<id>`.
      #   - Purchase: CEX token code (e.g. `CEX_1` for USDT). Get from `getPayTokenList`.
      #   - Redeem: DEX token code (e.g. `DEX_123`). Get from `getBizTokenList` or `getAssetList`.
      # @param from_token_amount [String] Amount to pay (string-formatted positive decimal for precision). Must be greater than 0.
      # @param to_token_code [String] Target token code. Format: `CEX_<id>` or `DEX_<id>`.
      #   - Purchase: DEX token code (e.g. `DEX_123`). Get from `getBizTokenList`.
      #   - Redeem: CEX token code (e.g. `CEX_1` for USDT). Get from `getPayTokenList`.
      # @option kwargs [Integer] :quote_mode Quote mode.
      #   - `0`: Auto (default) - system selects optimal mode
      #   - `1`: Price Priority - best price, may have higher failure rate
      #   - `2`: Success Rate Priority - guaranteed execution, price may be slightly worse
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/trade-quote
      def get_trade_quote(trade_type:, from_token_code:, from_token_amount:, to_token_code:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(tradeType: trade_type, fromTokenCode: from_token_code, fromTokenAmount: from_token_amount, toTokenCode: to_token_code))
        @session.sign_request(method: :post, path: '/v5/alpha/trade/quote', body: params)
      end

      # Execute a sell order to redeem on-chain tokens for USDT/USDC, returns order number
      #
      # POST /v5/alpha/trade/redeem
      #
      # @param from_token_code [String] On-chain token to sell (`DEX_<id>`). Must match the quote request.
      # @param from_token_amount [String] Amount to sell (positive decimal as string). Must match the quote request.
      # @param to_token_code [String] Payment token to receive (`CEX_<id>`, e.g. `CEX_1` for USDT). Must match the quote request.
      # @param slippage [String] Slippage tolerance as decimal.
      #   - `0.005` = 0.5%
      #   - `0.01` = 1%
      #   - `0.05` = 5%
      # @param quote_data [String] Base64-encoded quote data. **Must pass as-is from `/quote` response.**
      # @param gas [String] Estimated gas fee. **Must pass as-is from `/quote` response.**
      # @param quote_mode [Integer] Quote mode. Must be consistent with the `/quote` request.
      #   - `0`: Auto
      #   - `1`: Price Priority
      #   - `2`: Success Rate Priority
      # @param correcting_code [String] MD5 checksum for data integrity. **Must pass as-is from `/quote` response.**
      # @option kwargs [String] :tenant Optional tenant identifier.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/alpha/trade/trade-redeem
      def execute_redeem(from_token_code:, from_token_amount:, to_token_code:, slippage:, quote_data:, gas:, quote_mode:, correcting_code:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(fromTokenCode: from_token_code, fromTokenAmount: from_token_amount, toTokenCode: to_token_code, slippage: slippage, quoteData: quote_data, gas: gas, quoteMode: quote_mode, correctingCode: correcting_code))
        @session.sign_request(method: :post, path: '/v5/alpha/trade/redeem', body: params)
      end
    end
  end
end
