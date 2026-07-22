# frozen_string_literal: true

module Bybit
  module RestApi
    # /v5/ins-loan/* — institutional (OTC) loan namespace. Distinct from
    # `crypto_loan` (retail flexible / fixed loans): these endpoints require
    # a Bybit-provisioned institutional risk-unit UID and are read-only for
    # non-institutional keys.
    class InstitutionalLoanService < BaseService
      # Get Product Info
      #
      # GET /v5/ins-loan/product-infos
      #
      # @option kwargs [String] :product_id Product ID; omit to return all products.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/margin-product-info
      def get_product_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/ins-loan/product-infos', params: params)
      end

      # Get Margin Coin Info (ensure-tokens-convert)
      #
      # GET /v5/ins-loan/ensure-tokens-convert
      #
      # @option kwargs [String] :product_id Product ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/margin-coin-convert-info
      def get_margin_coin_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/ins-loan/ensure-tokens-convert', params: params)
      end

      # Get Loan Orders
      #
      # GET /v5/ins-loan/loan-order
      #
      # @option kwargs [Integer] :order_id Loan order ID
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [Integer] :limit Records per page (default/max 100)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/loan-info
      def get_loan_orders(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/ins-loan/loan-order', params: params)
      end

      # Get Repayment Orders
      #
      # GET /v5/ins-loan/repaid-history
      #
      # @option kwargs [Integer] :start_time Start timestamp in ms
      # @option kwargs [Integer] :end_time End timestamp in ms
      # @option kwargs [Integer] :limit Records per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/repay-info
      def get_repayment_orders(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/ins-loan/repaid-history', params: params)
      end

      # Get Loan-to-Value
      #
      # GET /v5/ins-loan/ltv-convert
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/ltv-convert
      def get_ltv
        @session.sign_request(method: :get, path: '/v5/ins-loan/ltv-convert')
      end

      # Bind Or Unbind UID (institutional risk unit)
      #
      # POST /v5/ins-loan/association-uid
      #
      # @param uid [String] Sub UID to bind or unbind
      # @param operate [String] `0` bind, `1` unbind
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/bind-uid
      def bind_or_unbind_uid(uid:, operate:, **kwargs)
        params = kwargs.merge(uid: uid, operate: operate)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/ins-loan/association-uid', body: params)
      end

      # Repay Loan
      #
      # POST /v5/ins-loan/repay-loan
      #
      # @param order_id [String] Loan order ID to repay
      # @param amount [String] Repayment amount
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/otc/repay-loan
      def repay_loan(order_id:, amount:, **kwargs)
        params = kwargs.merge(order_id: order_id, amount: amount)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/ins-loan/repay-loan', body: params)
      end
    end
  end
end
