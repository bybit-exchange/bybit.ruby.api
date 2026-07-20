# frozen_string_literal: true

module Bybit
  module RestApi
    class AssetService < BaseService
      # Get Coin Balance
      #
      # GET /v5/asset/transfer/query-account-coins-balance
      #
      # @param account_type [String] Account type
      # @option kwargs [String] :member_id User ID. Required when querying sub UID balance with master API key
      # @option kwargs [String] :coin Coin name(s). Multiple coins separated by comma. If not passed, returns all coins
      # @option kwargs [Integer] :with_bonus 0(default): not include bonus; 1: include bonus
      def get_coin_balance(account_type:, **kwargs)
        params = kwargs.merge(account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-account-coins-balance', params: params)
      end

      # Get Coin Greeks
      #
      # GET /v5/asset/coin-greeks
      #
      # @option kwargs [String] :base_coin Base coin. Default: return all your coins greek data
      def get_coin_greeks(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/coin-greeks', params: params)
      end

      # Get Funding History
      #
      # GET /v5/asset/fundinghistory
      #
      # @option kwargs [String] :create_time_from Start timestamp (ms)
      # @option kwargs [String] :create_time_to End timestamp (ms)
      # @option kwargs [String] :limit Limit for data size per page. [1, 50]. Default: 20
      # @option kwargs [String] :cursor Cursor. Used for pagination
      def query_funding_detail(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/fundinghistory', params: params)
      end
    end
  end
end
