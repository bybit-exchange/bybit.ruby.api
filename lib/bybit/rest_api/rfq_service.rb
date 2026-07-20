# frozen_string_literal: true

module Bybit
  module RestApi
    class RfqService < BaseService
      # Accept a non-LP quote for an RFQ.
      #
      # POST /v5/rfq/accept-other-quote
      #
      # @param rfq_id [String] RFQ ID
      def accept_non_lp_quote(rfq_id:, **kwargs)
        params = kwargs.merge(rfq_id: rfq_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/accept-other-quote', body: params)
      end

      # Cancel all active quotes.
      #
      # POST /v5/rfq/cancel-all-quotes
      def cancel_all_quotes(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/cancel-all-quotes', body: params)
      end

      # Cancel all active RFQs.
      #
      # POST /v5/rfq/cancel-all-rfq
      def cancel_all_rfqs(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/cancel-all-rfq', body: params)
      end

      # Cancel a specific quote by quote ID, RFQ ID, or quote link ID.
      #
      # POST /v5/rfq/cancel-quote
      #
      # @option kwargs [String] :quote_id Quote ID
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :quote_link_id User-defined quote link ID
      def cancel_quote(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/cancel-quote', body: params)
      end

      # Cancel a specific RFQ by RFQ ID or RFQ link ID.
      #
      # POST /v5/rfq/cancel-rfq
      #
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :rfq_link_id User-defined RFQ link ID
      def cancel_rfq(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/cancel-rfq', body: params)
      end

      # Create a quote in response to an RFQ.
      #
      # POST /v5/rfq/create-quote
      #
      # @param rfq_id [String] RFQ ID
      # @option kwargs [String] :quote_link_id User-defined quote link ID
      # @option kwargs [Boolean] :anonymous Whether to submit the quote anonymously
      # @option kwargs [Integer] :expire_in Expiration time in seconds
      # @option kwargs [Array] :quote_buy_list Buy side quote entries
      # @option kwargs [Array] :quote_sell_list Sell side quote entries
      def create_quote(rfq_id:, **kwargs)
        params = kwargs.merge(rfq_id: rfq_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/create-quote', body: params)
      end

      # Create a new RFQ (Request for Quote).
      #
      # POST /v5/rfq/create-rfq
      #
      # @param counterparties [Array] List of counterparties to receive the RFQ
      # @param list [Array] List of legs for the RFQ
      # @option kwargs [String] :rfq_link_id User-defined RFQ link ID
      # @option kwargs [Boolean] :anonymous Whether to submit the RFQ anonymously
      # @option kwargs [String] :strategy_type Strategy type
      def create_rfq(counterparties:, list:, **kwargs)
        params = kwargs.merge(counterparties: counterparties, list: list)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/create-rfq', body: params)
      end

      # Execute a quote to complete the trade.
      #
      # POST /v5/rfq/execute-quote
      #
      # @param rfq_id [String] RFQ ID
      # @param quote_id [String] Quote ID
      # @param quote_side [String] Quote side (Buy or Sell)
      def execute_quote(rfq_id:, quote_id:, quote_side:, **kwargs)
        params = kwargs.merge(rfq_id: rfq_id, quote_id: quote_id, quote_side: quote_side)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/rfq/execute-quote', body: params)
      end

      # Query public RFQ trades.
      #
      # GET /v5/rfq/public-trades
      #
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds
      # @option kwargs [Integer] :end_time End timestamp in milliseconds
      # @option kwargs [Integer] :limit Maximum number of records to return
      # @option kwargs [String] :cursor Pagination cursor
      def get_public_trades(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/public-trades', params: params)
      end

      # Query historical quotes.
      #
      # GET /v5/rfq/quote-list
      #
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :quote_id Quote ID
      # @option kwargs [String] :quote_link_id User-defined quote link ID
      # @option kwargs [String] :trader_type Trader type (Taker or Maker)
      # @option kwargs [String] :status Quote status filter
      # @option kwargs [Integer] :limit Maximum number of records to return
      # @option kwargs [String] :cursor Pagination cursor
      def get_quotes(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/quote-list', params: params)
      end

      # Query realtime (active) quotes.
      #
      # GET /v5/rfq/quote-realtime
      #
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :quote_id Quote ID
      # @option kwargs [String] :quote_link_id User-defined quote link ID
      # @option kwargs [String] :trader_type Trader type (Taker or Maker)
      def get_quotes_realtime(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/quote-realtime', params: params)
      end

      # Query RFQ configuration information.
      #
      # GET /v5/rfq/config
      def get_config(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/config', params: params)
      end

      # Query historical RFQs.
      #
      # GET /v5/rfq/rfq-list
      #
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :rfq_link_id User-defined RFQ link ID
      # @option kwargs [String] :trader_type Trader type (Taker or Maker)
      # @option kwargs [String] :status RFQ status filter
      # @option kwargs [Integer] :limit Maximum number of records to return
      # @option kwargs [String] :cursor Pagination cursor
      def get_rfqs(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/rfq-list', params: params)
      end

      # Query realtime (active) RFQs.
      #
      # GET /v5/rfq/rfq-realtime
      #
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :rfq_link_id User-defined RFQ link ID
      # @option kwargs [String] :trader_type Trader type (Taker or Maker)
      def get_rfqs_realtime(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/rfq-realtime', params: params)
      end

      # Query RFQ trade history.
      #
      # GET /v5/rfq/trade-list
      #
      # @option kwargs [String] :rfq_id RFQ ID
      # @option kwargs [String] :rfq_link_id User-defined RFQ link ID
      # @option kwargs [String] :quote_id Quote ID
      # @option kwargs [String] :quote_link_id User-defined quote link ID
      # @option kwargs [String] :trader_type Trader type (Taker or Maker)
      # @option kwargs [String] :status Trade status filter
      # @option kwargs [Integer] :limit Maximum number of records to return
      # @option kwargs [String] :cursor Pagination cursor
      def get_trade_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/rfq/trade-list', params: params)
      end
    end
  end
end
