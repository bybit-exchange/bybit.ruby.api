# frozen_string_literal: true

module Bybit
  module RestApi
    class FiatService < BaseService
      # Query Account Balance
      #
      # GET /v5/fiat/balance-query
      #
      # @option kwargs [String] :account_category Account type (reserved field)
      # @option kwargs [String] :currency Currency code:
      #   - Fiat: ISO 4217 standard code, e.g., EUR, GEL, KZT
      #   - Crypto: e.g., USDT, BTC, ETH
      #   - Omit to query all balances
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/balance-query
      def query_balance(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/fiat/balance-query', params: params)
      end

      # Get Trading Pairs
      #
      # GET /v5/fiat/query-coin-list
      #
      # @option kwargs [Integer] :side Trading direction:
      #   - `0`: buy - Buy crypto, sell fiat
      #   - `1`: sell - Sell crypto, buy fiat
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/query-coin-list
      def query_coin_list(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/fiat/query-coin-list', params: params)
      end

      # Query Trade History
      #
      # GET /v5/fiat/query-trade-history
      #
      # @option kwargs [Integer] :index Page number, starts from 1
      # @option kwargs [Integer] :limit Page size, maximum 100
      # @option kwargs [String] :start_time Query start time (millisecond timestamp)
      # @option kwargs [String] :end_time Query end time (millisecond timestamp)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/query-trade-history
      def query_trade_history(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/fiat/query-trade-history', params: params)
      end

      # Request a Quote
      #
      # POST /v5/fiat/quote-apply
      #
      # @param from_coin [String] Convert from coin (coin to sell)
      # @param from_coin_type [String] From coin type
      # @param to_coin [String] Convert to coin (coin to buy)
      # @param to_coin_type [String] To coin type
      # @param request_amount [String] Request coin amount (the amount you want to sell)
      # @option kwargs [String] :request_coin_type Coin type you want to sell, defaults to fiat
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/quote-apply
      def apply_quote(from_coin:, from_coin_type:, to_coin:, to_coin_type:, request_amount:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(fromCoin: from_coin, fromCoinType: from_coin_type, toCoin: to_coin, toCoinType: to_coin_type, requestAmount: request_amount))
        @session.sign_request(method: :post, path: '/v5/fiat/quote-apply', body: params)
      end

      # Get Reference Price
      #
      # GET /v5/fiat/reference-price
      #
      # @param symbol [String] Coin pair, format: "FIAT-CRYPTO", e.g., "EUR-USDT"
      # @option kwargs [String] :payment_method Payment method (reserved field)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/reference-price
      def get_reference_price(symbol:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(symbol: symbol))
        @session.sign_request(method: :get, path: '/v5/fiat/reference-price', params: params)
      end

      # Confirm Quote and Execute Trade
      #
      # POST /v5/fiat/trade-execute
      #
      # @param quote_tx_id [String] Quote transaction ID from the quote request
      # @param sub_user_id [String] The user's sub userId in Bybit
      # @option kwargs [String] :webhook_url Optional webhook URL to receive trade status notifications (max 256 characters)
      # @option kwargs [String] :merchant_request_id Customised request ID (max 36 characters). Generally it is useless, but convenient for internal tracking
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/confirm-quote
      def confirm_quote(quote_tx_id:, sub_user_id:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(quoteTxId: quote_tx_id, subUserId: sub_user_id))
        @session.sign_request(method: :post, path: '/v5/fiat/trade-execute', body: params)
      end

      # Query Trade Status
      #
      # GET /v5/fiat/trade-query
      #
      # @option kwargs [String] :trade_no Trade order number (either tradeNo or merchantRequestId must be provided)
      # @option kwargs [String] :merchant_request_id Merchant request ID (either tradeNo or merchantRequestId must be provided)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/fiat-convert/query-trade
      def query_trade(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/fiat/trade-query', params: params)
      end
    end
  end
end
