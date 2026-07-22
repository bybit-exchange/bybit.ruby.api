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
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
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
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
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
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_funding_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/fundinghistory', params: params)
      end

      # Get Coin Info
      #
      # GET /v5/asset/coin/query-info
      #
      # @option kwargs [String] :coin Coin name, uppercase only. e.g. BTC, ETH. If not passed, return all coin info.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/coin/query-info
      def get_coin_info(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/coin/query-info', params: params)
      end

      # Get Deposit Records (on-chain)
      #
      # GET /v5/asset/deposit/query-record
      #
      # @option kwargs [String] :id Internal ID. Takes highest priority when combined with other params.
      # @option kwargs [String] :tx_id Transaction ID. Only works for data from Jan 1, 2024 onward.
      # @option kwargs [String] :coin Coin symbol (uppercase only), e.g. `BTC`, `USDT`. Empty means query all coins.
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds. Defaults to 30 days ago if not provided.
      # @option kwargs [Integer] :end_time End timestamp in milliseconds. Defaults to current time if not provided.
      # @option kwargs [Integer] :limit Records per page. Range `[1, 50]`, default `50`.
      # @option kwargs [String] :cursor Pagination cursor from `nextPageCursor` in prior response.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/deposit/query-record
      def list_deposit_records(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/deposit/query-record', params: params)
      end

      # Get Master Deposit Address
      #
      # GET /v5/asset/deposit/query-address
      #
      # @param coin [String] Coin symbol (uppercase only), e.g. `USDT`.
      # @option kwargs [String] :chain_type Chain type. Use `chain` value from the coin-info endpoint. If not provided, returns all chains.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/deposit/query-address
      def get_deposit_address(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/deposit/query-address', params: params)
      end

      # Get Sub Deposit Address
      #
      # GET /v5/asset/deposit/query-sub-member-address
      #
      # @param coin [String] Coin symbol (uppercase only).
      # @param chain_type [String] Chain type. Use `chain` value from the coin-info endpoint.
      # @param sub_member_id [String] Sub-account user ID.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/deposit/query-sub-member-address
      def get_sub_member_deposit_address(coin:, chain_type:, sub_member_id:, **kwargs)
        params = kwargs.merge(coin: coin, chain_type: chain_type, sub_member_id: sub_member_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/deposit/query-sub-member-address', params: params)
      end

      # Get Sub Deposit Records (on-chain)
      #
      # GET /v5/asset/deposit/query-sub-member-record
      #
      # @param sub_member_id [String] Sub-account UID.
      # @option kwargs [String] :id Internal ID. Takes highest priority when combined with other params.
      # @option kwargs [String] :tx_id Transaction ID (data before Jan 1, 2024 not queryable via txID).
      # @option kwargs [String] :coin Coin symbol (uppercase only). Empty means query all.
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds. Defaults to 30 days ago.
      # @option kwargs [Integer] :end_time End timestamp in milliseconds. Defaults to current time.
      # @option kwargs [Integer] :limit Records per page. Range `[1, 50]`, default `50`.
      # @option kwargs [String] :cursor Pagination cursor from `nextPageCursor`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/deposit/query-sub-member-record
      def list_sub_member_deposit_records(sub_member_id:, **kwargs)
        params = kwargs.merge(sub_member_id: sub_member_id)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/deposit/query-sub-member-record', params: params)
      end

      # Get Internal Deposit Records (off-chain)
      #
      # GET /v5/asset/deposit/query-internal-record
      #
      # @option kwargs [String] :tx_id Internal transfer transaction ID.
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds. Defaults to 30 days ago.
      # @option kwargs [Integer] :end_time End timestamp in milliseconds. Defaults to current time.
      # @option kwargs [String] :coin Coin symbol (uppercase only). Empty means query all.
      # @option kwargs [String] :cursor Pagination cursor.
      # @option kwargs [Integer] :limit Records per page. Range `[1, 50]`, default `50`.
      # @option kwargs [String] :status Filter by status. `0` = all (default).
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/deposit/query-internal-record
      def list_internal_deposit_records(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/deposit/query-internal-record', params: params)
      end

      # Set Deposit Account
      #
      # POST /v5/asset/deposit/deposit-to-account
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/deposit/deposit-to-account
      def set_default_deposit_to_account(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/deposit/deposit-to-account', body: params)
      end

      # Create Internal Transfer
      #
      # POST /v5/asset/transfer/inter-transfer
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/inter-transfer
      def inter_transfer(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/transfer/inter-transfer', body: params)
      end

      # Create Universal Transfer
      #
      # POST /v5/asset/transfer/universal-transfer
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/universal-transfer
      def universal_transfer(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/transfer/universal-transfer', body: params)
      end

      # Save Transferable Sub Member List
      #
      # POST /v5/asset/transfer/save-transfer-sub-member
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/save-transfer-sub-member
      def transfer_sub_member_save(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/transfer/save-transfer-sub-member', body: params)
      end

      # Get Internal Transfer Records
      #
      # GET /v5/asset/transfer/query-inter-transfer-list
      #
      # @option kwargs [String] :transfer_id UUID of the transfer. If provided, queries a single record by transferId.
      # @option kwargs [String] :coin Coin name, uppercase (e.g. BTC, USDT)
      # @option kwargs [String] :status Filter by transfer status
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds (effective at second level)
      # @option kwargs [Integer] :end_time End timestamp in milliseconds (effective at second level)
      # @option kwargs [Integer] :limit Number of records per page. Default: 20, Range: [1, 50]
      # @option kwargs [String] :cursor Pagination cursor from `nextPageCursor` of previous response
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/query-inter-transfer-list
      def inter_transfer_list_query(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-inter-transfer-list', params: params)
      end

      # Get Universal Transfer Records
      #
      # GET /v5/asset/transfer/query-universal-transfer-list
      #
      # @option kwargs [String] :transfer_id UUID of the transfer
      # @option kwargs [String] :coin Coin name, uppercase
      # @option kwargs [String] :status Filter by transfer status: SUCCESS, FAILED, PENDING
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds (effective at second level)
      # @option kwargs [Integer] :end_time End timestamp in milliseconds (effective at second level)
      # @option kwargs [Integer] :limit Number of records per page. Default: 20, Range: [1, 50]
      # @option kwargs [String] :cursor Pagination cursor from `nextPageCursor`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/query-universal-transfer-list
      def universal_transfer_list_query(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-universal-transfer-list', params: params)
      end

      # Get Transferable Coin List
      #
      # GET /v5/asset/transfer/query-transfer-coin-list
      #
      # @param from_account_type [String] Source account type
      # @param to_account_type [String] Destination account type
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/query-transfer-coin-list
      def transfer_coin_list_query(from_account_type:, to_account_type:, **kwargs)
        params = kwargs.merge(from_account_type: from_account_type, to_account_type: to_account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-transfer-coin-list', params: params)
      end

      # Get Sub UID List
      #
      # GET /v5/asset/transfer/query-sub-member-list
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/query-sub-member-list
      def sub_member_list_query(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-sub-member-list', params: params)
      end

      # Get Single Coin Balance
      #
      # GET /v5/asset/transfer/query-account-coin-balance
      #
      # @param account_type [String] Account type
      # @param coin [String] Coin name, uppercase (e.g. USDT, BTC). Required.
      # @option kwargs [Integer] :member_id UID. Required when querying sub UID balance with master API key
      # @option kwargs [Integer] :to_member_id Target UID. Required for cross-UID transferable balance query
      # @option kwargs [String] :to_account_type Destination account type. Required when `withLtvTransferSafeAmount=1`
      # @option kwargs [Integer] :with_bonus `0` (default): exclude bonus; `1`: include bonus
      # @option kwargs [Integer] :with_transfer_safe_amount `0` (default): not query; `1`: query delay-withdraw safe amount
      # @option kwargs [Integer] :with_ltv_transfer_safe_amount `0` (default): not query; `1`: query OTC loan transferable amount. Requires `toAccountType`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/query-account-coin-balance
      def account_coin_balance_query(account_type:, coin:, **kwargs)
        params = kwargs.merge(account_type: account_type, coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-account-coin-balance', params: params)
      end

      # Get Spot Asset Info
      #
      # GET /v5/asset/transfer/query-asset-info
      #
      # @option kwargs [String] :account_type Account type. Currently only SPOT. Defaults to SPOT if empty.
      # @option kwargs [String] :coin Coin name, uppercase. Optional; returns all coins if empty.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/transfer/query-asset-info
      def asset_info_query(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/transfer/query-asset-info', params: params)
      end

      # Withdraw
      #
      # POST /v5/asset/withdraw/create
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/withdraw/create
      def send_withdraw(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/withdraw/create', body: params)
      end

      # Get Withdrawal Records
      #
      # GET /v5/asset/withdraw/query-record
      #
      # @option kwargs [String] :withdraw_id Withdrawal ID
      # @option kwargs [String] :tx_id Transaction hash ID
      # @option kwargs [String] :coin Coin name, uppercase, e.g. USDT
      # @option kwargs [Integer] :withdraw_type Withdrawal type: - `0`: On-chain withdrawal (default) - `1`: Off-chain (internal transfer) - `2`: Al
      # @option kwargs [Integer] :start_time Start timestamp in milliseconds. Default: 30 days before current time
      # @option kwargs [Integer] :end_time End timestamp in milliseconds. Default: current time
      # @option kwargs [Integer] :limit Results per page, range [1, 50], default 50
      # @option kwargs [String] :cursor Pagination cursor from `nextPageCursor` in prior response
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/withdraw/query-record
      def list_withdraw_records(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/withdraw/query-record', params: params)
      end

      # Cancel Withdrawal
      #
      # POST /v5/asset/withdraw/cancel
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/withdraw/cancel
      def cancel_withdraw(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/withdraw/cancel', body: params)
      end

      # Get Withdrawable Amount
      #
      # GET /v5/asset/withdraw/withdrawable-amount
      #
      # @param coin [String] Coin name, uppercase, e.g. USDT
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/withdraw/withdrawable-amount
      def get_withdrawable_amount_by_coin(coin:, **kwargs)
        params = kwargs.merge(coin: coin)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/withdraw/withdrawable-amount', params: params)
      end

      # Get Available VASPs
      #
      # GET /v5/asset/withdraw/vasp/list
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/withdraw/vasp/list
      def get_vasp_list(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/withdraw/vasp/list', params: params)
      end

      # Get Withdrawal Address List
      #
      # GET /v5/asset/withdraw/query-address
      #
      # @option kwargs [String] :coin Coin name; use `baseCoin` for universal addresses
      # @option kwargs [String] :chain Chain name
      # @option kwargs [Integer] :address_type Address type: - `0`: On-chain address (default) - `1`: Internal transfer address (coin/chain ignored
      # @option kwargs [Integer] :limit Records per page, range [1, 50], default 50
      # @option kwargs [String] :cursor Pagination cursor from `nextPageCursor` in prior response
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/withdraw/query-address
      def list_withdraw_addresses(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/withdraw/query-address', params: params)
      end

      # Get Asset Overview
      #
      # GET /v5/asset/asset-overview
      #
      # @option kwargs [String] :account_type Account type filter. Multiple values separated by commas. If not passed, returns all account types.
      # @option kwargs [String] :member_id Sub-account member ID. Used to query a specific sub-account's assets. - If API key belongs to a sub-
      # @option kwargs [String] :valuation_currency Valuation currency. Defaults to `USD` if not provided.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/asset-overview
      def get_asset_overview(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/asset-overview', params: params)
      end

      # Get Delivery Record
      #
      # GET /v5/asset/delivery-record
      #
      # @param category [String] Product type: - `linear`: USDT / USDC futures - `inverse`: Inverse futures - `option`: Options
      # @option kwargs [String] :symbol Symbol name, e.g. `BTCUSDT`, `BTC-29DEC22-16000-P`
      # @option kwargs [Integer] :start_time Start timestamp in **milliseconds**. Default: 30 days before current time
      # @option kwargs [Integer] :end_time End timestamp in **milliseconds**. Default: current time
      # @option kwargs [String] :exp_date Expiry date. Format: `25DEC22`. Default: returns all expiry dates
      # @option kwargs [Integer] :limit Number of items per page. Default: `20`, Range: [`1`, `50`]
      # @option kwargs [String] :cursor Pagination cursor. Use `nextPageCursor` from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/delivery-record
      def get_delivery_record(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/delivery-record', params: params)
      end

      # Get Portfolio Margin Info
      #
      # GET /v5/asset/portfolio-margin
      #
      # @option kwargs [String] :base_coin Base coin, e.g. `BTC`, `ETH`. If not passed, returns all.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/portfolio-margin
      def get_portfolio_margin(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/portfolio-margin', params: params)
      end

      # Get USDC Session Settlement
      #
      # GET /v5/asset/settlement-record
      #
      # @param category [String] Product type: - `linear`: USDC contract
      # @option kwargs [String] :symbol Symbol name, e.g. `BTCPERP`
      # @option kwargs [Integer] :start_time Start timestamp in **milliseconds**. Default: 30 days before current time
      # @option kwargs [Integer] :end_time End timestamp in **milliseconds**. Default: current time
      # @option kwargs [Integer] :limit Number of items per page. Default: `20`, Range: [`1`, `50`]
      # @option kwargs [String] :cursor Pagination cursor. Use `nextPageCursor` from the response to retrieve the next page
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/settlement-record
      def get_settlement_record(category:, **kwargs)
        params = kwargs.merge(category: category)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/settlement-record', params: params)
      end

      # Get Total Members Assets
      #
      # GET /v5/asset/total-members-assets
      #
      # @option kwargs [String] :coin Coin name, e.g. `BTC`, `USDT`. If specified, total assets are denominated in this coin.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/total-members-assets
      def get_total_members_assets(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/total-members-assets', params: params)
      end

      # Coin list query
      #
      # GET /v5/asset/exchange/query-coin-list
      #
      # @param account_type [String] Wallet type. Supported values: eb_convert_funding, eb_convert_uta, eb_convert_spot, eb_convert_contr
      # @option kwargs [Integer] :side 0: fromCoin list (coins to sell); 1: toCoin list (coins to buy)
      # @option kwargs [String] :coin Coin name, uppercase only. Used as fromCoin filter when side=0
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/query-coin-list
      def coin_list_query(account_type:, **kwargs)
        params = kwargs.merge(account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/exchange/query-coin-list', params: params)
      end

      # Execute conversion
      #
      # POST /v5/asset/exchange/convert-execute
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/convert-execute
      def convert_execute(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/exchange/convert-execute', body: params)
      end

      # Conversion history query
      #
      # GET /v5/asset/exchange/query-convert-history
      #
      # @option kwargs [String] :account_type Wallet type filter. Supported: eb_convert_funding, eb_convert_uta, funding, funding_fiat, funding_fb
      # @option kwargs [Integer] :index Page number, starts at 1, defaults to 1
      # @option kwargs [Integer] :limit Page size, default 20, max 100
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/query-convert-history
      def convert_history_query(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/exchange/query-convert-history', params: params)
      end

      # Query coin conversion limit
      #
      # GET /v5/asset/exchange/query-convert-limit
      #
      # @param from_coin [String] From coin
      # @param to_coin [String] To coin
      # @param account_type [String] Account type (scene code), pass "funding" for funding account flash conversion
      # @option kwargs [Integer] :from_coin_type From coin type: 0=crypto, 1=fiat
      # @option kwargs [Integer] :to_coin_type To coin type: 0=crypto, 1=fiat
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/query-convert-limit
      def coin_convert_limit_query(from_coin:, to_coin:, account_type:, **kwargs)
        params = kwargs.merge(from_coin: from_coin, to_coin: to_coin, account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/exchange/query-convert-limit', params: params)
      end

      # Query conversion result
      #
      # GET /v5/asset/exchange/convert-result-query
      #
      # @param quote_tx_id [String] Quote transaction ID
      # @param account_type [String] Wallet type (scene code)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/convert-result-query
      def get_convert_result(quote_tx_id:, account_type:, **kwargs)
        params = kwargs.merge(quote_tx_id: quote_tx_id, account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/exchange/convert-result-query', params: params)
      end

      # Paginated conversion order query
      #
      # GET /v5/asset/exchange/order-record
      #
      # @option kwargs [String] :cursor Pagination cursor (omit on first request)
      # @option kwargs [Integer] :limit Items per page
      # @option kwargs [String] :to_coin To coin filter
      # @option kwargs [String] :from_coin From coin filter
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/order-record
      def list_convert_orders_by_page(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/exchange/order-record', params: params)
      end

      # Query conversion order list
      #
      # GET /v5/asset/exchange/query-order-list
      #
      # @option kwargs [Integer] :account_type Account type: 0=ASSET, 1=OBU
      # @option kwargs [String] :cursor Pagination cursor
      # @option kwargs [Integer] :limit Items per page
      # @option kwargs [String] :to_coin To coin filter
      # @option kwargs [String] :from_coin From coin filter
      # @option kwargs [Integer] :start_time Start timestamp (seconds)
      # @option kwargs [Integer] :end_time End timestamp (seconds)
      # @option kwargs [Integer] :type Conversion type: 0=all, 1=auto conversion, 2=active conversion
      # @option kwargs [Integer] :exchange_status Order status: 0=all, 1=init, 2=pending, 3=success, 4=failure
      # @option kwargs [String] :direction Pagination direction
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/query-order-list
      def list_convert_orders(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/exchange/query-order-list', params: params)
      end

      # Apply quote
      #
      # POST /v5/asset/exchange/quote-apply
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/exchange/quote-apply
      def quote_apply(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/exchange/quote-apply', body: params)
      end

      # Small asset confirm conversion
      #
      # POST /v5/asset/covert/small-balance-execute
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/covert/small-balance-execute
      def small_asset_convert(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/covert/small-balance-execute', body: params)
      end

      # Small asset conversion history query
      #
      # GET /v5/asset/covert/small-balance-history
      #
      # @option kwargs [String] :account_type Wallet type: eb_convert_uta or eb_convert_funding
      # @option kwargs [String] :quote_id Quote ID. Highest priority filter when provided
      # @option kwargs [String] :cursor Page number for pagination
      # @option kwargs [String] :size Page size, default 50, max 100
      # @option kwargs [String] :start_time Start timestamp in milliseconds
      # @option kwargs [String] :end_time End timestamp in milliseconds
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/covert/small-balance-history
      def list_small_balance_history(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/covert/small-balance-history', params: params)
      end

      # Small asset conversion list query
      #
      # GET /v5/asset/covert/small-balance-list
      #
      # @param account_type [String] Wallet type. Only supports eb_convert_uta (Unified wallet)
      # @option kwargs [String] :from_coin Source currency filter (optional). Multiple coins separated by comma, e.g. "BTC,ETH"
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/covert/small-balance-list
      def list_small_balance_coins(account_type:, **kwargs)
        params = kwargs.merge(account_type: account_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/asset/covert/small-balance-list', params: params)
      end

      # Small asset get quote
      #
      # POST /v5/asset/covert/get-quote
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/asset/covert/get-quote
      def small_asset_quote(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/asset/covert/get-quote', body: params)
      end
    end
  end
end
