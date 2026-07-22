# frozen_string_literal: true

module Bybit
  module RestApi
    class CryptoLoanService < BaseService
      # Adjust collateral by adding or removing amount for crypto loan.
      #
      # POST /v5/crypto-loan-common/adjust-ltv
      #
      # @param currency [String] Collateral currency
      # @param amount [String] Amount to adjust
      # @param direction [Integer] Adjustment direction: add or remove collateral
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def adjust_ltv(currency:, amount:, direction:, **kwargs)
        params = kwargs.merge(currency: currency, amount: amount, direction: direction)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-common/adjust-ltv', body: params)
      end

      # Get collateral adjustment history for crypto loan positions.
      #
      # GET /v5/crypto-loan-common/adjustment-history
      #
      # @option kwargs [Integer] :adjust_id Adjustment record ID
      # @option kwargs [String] :collateral_currency Collateral currency filter
      # @option kwargs [Integer] :limit Number of records per page
      # @option kwargs [Integer] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_adjustment_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-common/adjustment-history', params: params)
      end

      # Get collateral currency data for crypto loan.
      #
      # GET /v5/crypto-loan-common/collateral-data
      #
      # @option kwargs [String] :currency Collateral currency filter
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_collateral_data(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/crypto-loan-common/collateral-data', params: params)
      end

      # Get loanable currency data for crypto loan.
      #
      # GET /v5/crypto-loan-common/loanable-data
      #
      # @option kwargs [String] :currency Loanable currency filter
      # @option kwargs [String] :vip_level VIP level filter
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_loanable_data(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-common/loanable-data', params: params)
      end

      # Get maximum collateral redeem amount for a currency.
      #
      # GET /v5/crypto-loan-common/max-collateral-amount
      #
      # @param currency [String] Collateral currency
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_max_collateral_amount(currency:, **kwargs)
        params = kwargs.merge(currency: currency)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-common/max-collateral-amount', params: params)
      end

      # Calculate the maximum borrowable amount given collateral list.
      #
      # POST /v5/crypto-loan-common/max-loan
      #
      # @param currency [String] Loan currency
      # @param collateral_list [Array] List of collateral currencies and amounts
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_max_loan(currency:, collateral_list:, **kwargs)
        params = kwargs.merge(currency: currency, collateral_list: collateral_list)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-common/max-loan', body: params)
      end

      # Get current crypto loan position.
      #
      # GET /v5/crypto-loan-common/position
      def get_position
        @session.sign_request(method: :get, path: '/v5/crypto-loan-common/position')
      end

      # Get Borrow Contract Info
      #
      # GET /v5/crypto-loan-fixed/borrow-contract-info
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :loan_id Loan ID
      # @option kwargs [String] :order_currency Order currency
      # @option kwargs [String] :term Loan term
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor used for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_borrow_contract_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-fixed/borrow-contract-info', params: params)
      end

      # Get Borrow Order Info
      #
      # GET /v5/crypto-loan-fixed/borrow-order-info
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_currency Order currency
      # @option kwargs [String] :state Order state
      # @option kwargs [String] :term Loan term
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor used for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_borrow_order_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-fixed/borrow-order-info', params: params)
      end

      # Get Borrow Market Quotes
      #
      # GET /v5/crypto-loan-fixed/borrow-order-quote
      #
      # @option kwargs [String] :order_currency Order currency
      # @option kwargs [String] :term Loan term
      # @option kwargs [String] :order_by Order by field
      # @option kwargs [Integer] :sort Sort direction
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_borrow_order_quote(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/crypto-loan-fixed/borrow-order-quote', params: params)
      end

      # Get Renewal Information
      #
      # GET /v5/crypto-loan-fixed/renew-info
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_currency Order currency
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor used for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_renew_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-fixed/renew-info', params: params)
      end

      # Get Supply Contract Info
      #
      # GET /v5/crypto-loan-fixed/supply-contract-info
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :supply_id Supply ID
      # @option kwargs [String] :supply_currency Supply currency
      # @option kwargs [String] :term Loan term
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor used for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_supply_contract_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-fixed/supply-contract-info', params: params)
      end

      # Get Supply Order Info
      #
      # GET /v5/crypto-loan-fixed/supply-order-info
      #
      # @option kwargs [String] :order_id Order ID
      # @option kwargs [String] :order_currency Order currency
      # @option kwargs [String] :state Order state
      # @option kwargs [String] :term Loan term
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor used for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_supply_order_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-fixed/supply-order-info', params: params)
      end

      # Get Supply Market Quotes
      #
      # GET /v5/crypto-loan-fixed/supply-order-quote
      #
      # @option kwargs [String] :order_currency Order currency
      # @option kwargs [String] :term Loan term
      # @option kwargs [String] :order_by Order by field
      # @option kwargs [Integer] :sort Sort direction
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_fixed_supply_order_quote(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/crypto-loan-fixed/supply-order-quote', params: params)
      end

      # Create Fixed-Term Borrow Order
      #
      # POST /v5/crypto-loan-fixed/borrow
      #
      # @param order_currency [String] Order currency
      # @param order_amount [String] Order amount
      # @param annual_rate [String] Annual interest rate
      # @param term [String] Loan term
      # @param collateral_list [Array] List of collateral
      # @option kwargs [String] :auto_repay Auto repay flag
      # @option kwargs [String] :repay_type Repay type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def borrow_fixed(order_currency:, order_amount:, annual_rate:, term:, collateral_list:, **kwargs)
        params = kwargs.merge(order_currency: order_currency, order_amount: order_amount, annual_rate: annual_rate, term: term, collateral_list: collateral_list)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-fixed/borrow', body: params)
      end

      # Cancel Borrow Order
      #
      # POST /v5/crypto-loan-fixed/borrow-order-cancel
      #
      # @param order_id [String] Order ID
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def cancel_fixed_borrow_order(order_id:, **kwargs)
        params = kwargs.merge(order_id: order_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-fixed/borrow-order-cancel', body: params)
      end

      # Fully Repay Loan
      #
      # POST /v5/crypto-loan-fixed/fully-repay
      #
      # @param loan_id [String] Loan ID
      # @param loan_currency [String] Loan currency
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def repay_fixed_fully(loan_id:, loan_currency:, **kwargs)
        params = kwargs.merge(loan_id: loan_id, loan_currency: loan_currency)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-fixed/fully-repay', body: params)
      end

      # Renew Loan
      #
      # POST /v5/crypto-loan-fixed/renew
      #
      # @param loan_id [String] Loan ID
      # @param collateral_list [Array] List of collateral
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def renew_fixed(loan_id:, collateral_list:, **kwargs)
        params = kwargs.merge(loan_id: loan_id, collateral_list: collateral_list)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-fixed/renew', body: params)
      end

      # Repay with Collateral
      #
      # POST /v5/crypto-loan-fixed/repay-collateral
      #
      # @param loan_id [Integer] Loan ID
      # @param loan_currency [String] Loan currency
      # @param collateral_coin [String] Collateral coin
      # @param amount [String] Repay amount
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def repay_fixed_with_collateral(loan_id:, loan_currency:, collateral_coin:, amount:, **kwargs)
        params = kwargs.merge(loan_id: loan_id, loan_currency: loan_currency, collateral_coin: collateral_coin, amount: amount)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-fixed/repay-collateral', body: params)
      end

      # Cancel Supply Order
      #
      # POST /v5/crypto-loan-fixed/supply-order-cancel
      #
      # @param order_id [String] Order ID
      # @option kwargs [Integer] :refunded_account Refunded account
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def cancel_fixed_supply_order(order_id:, **kwargs)
        params = kwargs.merge(order_id: order_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-fixed/supply-order-cancel', body: params)
      end

      # Get Flexible Borrow History
      #
      # GET /v5/crypto-loan-flexible/borrow-history
      #
      # @option kwargs [String] :order_id Order ID of the borrow order
      # @option kwargs [String] :loan_currency Loan currency
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_flexible_borrow_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-flexible/borrow-history', params: params)
      end

      # Get Ongoing Flexible Borrow Info
      #
      # GET /v5/crypto-loan-flexible/ongoing-coin
      #
      # @option kwargs [String] :loan_currency Loan currency
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_flexible_ongoing_coin(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-flexible/ongoing-coin', params: params)
      end

      # Get Flexible Repayment History
      #
      # GET /v5/crypto-loan-flexible/repayment-history
      #
      # @option kwargs [String] :repay_id Repayment ID
      # @option kwargs [String] :loan_currency Loan currency
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [Integer] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_flexible_repayment_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/crypto-loan-flexible/repayment-history', params: params)
      end

      # Create Flexible Borrow Order
      #
      # POST /v5/crypto-loan-flexible/borrow
      #
      # @param loan_currency [String] Loan currency
      # @param loan_amount [String] Loan amount
      # @param collateral_list [Array] Collateral coin list
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def borrow_flexible(loan_currency:, loan_amount:, collateral_list:, **kwargs)
        params = kwargs.merge(loan_currency: loan_currency, loan_amount: loan_amount, collateral_list: collateral_list)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-flexible/borrow', body: params)
      end

      # Repay Flexible Loan
      #
      # POST /v5/crypto-loan-flexible/repay
      #
      # @param loan_currency [String] Loan currency
      # @param amount [String] Repayment amount
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def repay_flexible(loan_currency:, amount:, **kwargs)
        params = kwargs.merge(loan_currency: loan_currency, amount: amount)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-flexible/repay', body: params)
      end

      # Repay with Collateral
      #
      # POST /v5/crypto-loan-flexible/repay-collateral
      #
      # @param loan_currency [String] Loan currency
      # @param collateral_coin [String] Collateral coin
      # @param amount [String] Repayment amount
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def repay_flexible_with_collateral(loan_currency:, collateral_coin:, amount:, **kwargs)
        params = kwargs.merge(loan_currency: loan_currency, collateral_coin: collateral_coin, amount: amount)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/crypto-loan-flexible/repay-collateral', body: params)
      end
    end
  end
end
