# frozen_string_literal: true

module Bybit
  module RestApi
    class MarketService < BaseService
      # Get ADL alert information for the specified symbol.
      #
      # GET /v5/market/adlalert
      #
      # @option kwargs [String] :symbol Symbol name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/adl-alert
      def get_adl_alert(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/adlalert', params: params)
      end

      # Get the delivery price for delivery contracts.
      #
      # GET /v5/market/delivery-price
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/delivery-price
      def get_delivery_price(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/delivery-price', params: params)
      end

      # Get the fee group structure information.
      #
      # GET /v5/market/fee-group-info
      #
      # @param product_type [String] Product type
      # @option kwargs [String] :group_id Fee group id
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/fee-group-info
      def get_fee_group_info(product_type:, **kwargs)
        params = kwargs.merge(product_type: product_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/fee-group-info', params: params)
      end

      # Get the historical funding rate for a symbol.
      #
      # GET /v5/market/funding/history
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @option kwargs [Integer] :start_time Start timestamp (ms)
      # @option kwargs [Integer] :end_time End timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/history-fund-rate
      def get_funding_rate_history(category:, symbol:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/funding/history', params: params)
      end

      # Get the historical volatility for options.
      #
      # GET /v5/market/historical-volatility
      #
      # @param category [String] Product type
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [String] :quote_coin Quote coin
      # @option kwargs [Integer] :period Period
      # @option kwargs [Integer] :start_time Start timestamp (ms)
      # @option kwargs [Integer] :end_time End timestamp (ms)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/iv
      def get_historical_volatility(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/historical-volatility', params: params)
      end

      # Get the components of the index price.
      #
      # GET /v5/market/index-price-components
      #
      # @param index_name [String] Index name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_index_price_components(index_name:, **kwargs)
        params = kwargs.merge(index_name: index_name)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/index-price-components', params: params)
      end

      # Get index price kline data for a symbol.
      #
      # GET /v5/market/index-price-kline
      #
      # @param symbol [String] Symbol name
      # @param interval [String] Kline interval
      # @option kwargs [String] :category Product type
      # @option kwargs [Integer] :start Start timestamp (ms)
      # @option kwargs [Integer] :end_ End timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/index-kline
      def get_index_price_kline(symbol:, interval:, **kwargs)
        params = kwargs.merge(symbol: symbol, interval: interval)
        params[:end] = params.delete(:end_) if params.key?(:end_)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/index-price-kline', params: params)
      end

      # Get the specification of instruments.
      #
      # GET /v5/market/instruments-info
      #
      # @param category [String] Product type
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :status Symbol status filter
      # @option kwargs [String] :base_coin Base coin
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/instrument
      def get_instruments_info(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/instruments-info', params: params)
      end

      # Get the insurance pool balance data.
      #
      # GET /v5/market/insurance
      #
      # @option kwargs [String] :coin Coin name
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/insurance
      def get_insurance_pool(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/insurance', params: params)
      end

      # Get the long/short account ratio for a symbol.
      #
      # GET /v5/market/account-ratio
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param period [String] Data recording period
      # @option kwargs [String] :start_time Start timestamp (ms)
      # @option kwargs [String] :end_time End timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/long-short-ratio
      def get_long_short_ratio(category:, symbol:, period:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, period: period)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/account-ratio', params: params)
      end

      # Get mark price kline data for a symbol.
      #
      # GET /v5/market/mark-price-kline
      #
      # @param symbol [String] Symbol name
      # @param interval [String] Kline interval
      # @option kwargs [String] :category Product type
      # @option kwargs [Integer] :start Start timestamp (ms)
      # @option kwargs [Integer] :end_ End timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/mark-kline
      def get_mark_price_kline(symbol:, interval:, **kwargs)
        params = kwargs.merge(symbol: symbol, interval: interval)
        params[:end] = params.delete(:end_) if params.key?(:end_)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/mark-price-kline', params: params)
      end

      # Get kline (candlestick) data for a symbol.
      #
      # GET /v5/market/kline
      #
      # @param symbol [String] Symbol name
      # @param interval [String] Kline interval
      # @option kwargs [String] :category Product type
      # @option kwargs [Integer] :start Start timestamp (ms)
      # @option kwargs [Integer] :end_ End timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/kline
      def get_kline(symbol:, interval:, **kwargs)
        params = kwargs.merge(symbol: symbol, interval: interval)
        params[:end] = params.delete(:end_) if params.key?(:end_)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/kline', params: params)
      end

      # Get the new delivery price for delivery contracts.
      #
      # GET /v5/market/new-delivery-price
      #
      # @param category [String] Product type
      # @param base_coin [String] Base coin
      # @option kwargs [String] :settle_coin Settle coin
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/new-delivery-price
      def get_new_delivery_price(category:, base_coin:, **kwargs)
        params = kwargs.merge(category: category, base_coin: base_coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/new-delivery-price', params: params)
      end

      # Get the open interest data for a symbol.
      #
      # GET /v5/market/open-interest
      #
      # @param category [String] Product type
      # @param symbol [String] Symbol name
      # @param interval_time [String] Interval time
      # @option kwargs [Integer] :start_time Start timestamp (ms)
      # @option kwargs [Integer] :end_time End timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/open-interest
      def get_open_interest(category:, symbol:, interval_time:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol, interval_time: interval_time)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/open-interest', params: params)
      end

      # Get the order price limit for a symbol.
      #
      # GET /v5/market/price-limit
      #
      # @param symbol [String] Symbol name
      # @option kwargs [String] :category Product type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_order_price_limit(symbol:, **kwargs)
        params = kwargs.merge(symbol: symbol)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/price-limit', params: params)
      end

      # Get orderbook data for a specified symbol and category.
      #
      # GET /v5/market/orderbook
      #
      # @param category [String] Product type: spot, linear, inverse, option
      # @param symbol [String] Symbol name
      # @option kwargs [Integer] :limit Limit size for each bid/ask
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/orderbook
      def get_orderbook(category:, symbol:, **kwargs)
        params = kwargs.merge(category: category, symbol: symbol)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/orderbook', params: params)
      end

      # Get premium index price kline data.
      #
      # GET /v5/market/premium-index-price-kline
      #
      # @param symbol [String] Symbol name
      # @param interval [String] Kline interval
      # @option kwargs [String] :category Product type: linear
      # @option kwargs [Integer] :start The start timestamp (ms)
      # @option kwargs [Integer] :end_ The end timestamp (ms)
      # @option kwargs [Integer] :limit Limit for data size per page. [1, 1000]. Default: 200
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/premium-index-kline
      def get_premium_index_price_kline(symbol:, interval:, **kwargs)
        params = kwargs.merge(symbol: symbol, interval: interval)
        params[:end] = params.delete(:end_) if params.key?(:end_)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/premium-index-price-kline', params: params)
      end

      # Get recent public trades.
      #
      # GET /v5/market/recent-trade
      #
      # @param category [String] Product type: spot, linear, inverse, option
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin, for option only
      # @option kwargs [String] :option_type Option type: Call or Put, for option only
      # @option kwargs [Integer] :limit Limit for data size per page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/recent-trade
      def get_recent_public_trades(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/recent-trade', params: params)
      end

      # Get risk limit information.
      #
      # GET /v5/market/risk-limit
      #
      # @param category [String] Product type: linear, inverse
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :cursor Cursor for pagination
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/risk-limit
      def get_risk_limit(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/risk-limit', params: params)
      end

      # Get RPI (Retail Price Improvement) orderbook data.
      #
      # GET /v5/market/rpi_orderbook
      #
      # @param symbol [String] Symbol name
      # @param limit [Integer] Limit size for each bid/ask
      # @option kwargs [String] :category Product type: spot
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/rpi-orderbook
      def get_rpi_orderbook(symbol:, limit:, **kwargs)
        params = kwargs.merge(symbol: symbol, limit: limit)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/rpi_orderbook', params: params)
      end

      # Get Bybit server time.
      #
      # GET /v5/market/time
      #
      # @see https://bybit-exchange.github.io/docs/v5/market/time
      def get_server_time
        @session.public_request(path: '/v5/market/time')
      end

      # Get tickers information for a specified category.
      #
      # GET /v5/market/tickers
      #
      # @param category [String] Product type: spot, linear, inverse, option
      # @option kwargs [String] :symbol Symbol name
      # @option kwargs [String] :base_coin Base coin, for option only
      # @option kwargs [String] :exp_date Expiry date, for option only
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/market/tickers
      def get_tickers(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/market/tickers', params: params)
      end
    end
  end
end
