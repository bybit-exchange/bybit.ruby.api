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
      # @see https://bybit-exchange.github.io/docs/v5/spot-margin-uta/vip-margin
      def get_vip_margin_data(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.public_request(path: '/v5/spot-margin-trade/data', params: params)
      end
    end
  end
end
