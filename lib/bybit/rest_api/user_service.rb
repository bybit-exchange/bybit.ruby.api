# frozen_string_literal: true

module Bybit
  module RestApi
    class UserService < BaseService
      # Create Sub API Key.
      #
      # POST /v5/user/create-sub-api
      #
      # @param subuid [Integer] Sub UID
      # @param read_only [Integer] Read-only permission flag (0: read-write, 1: read-only)
      # @param permissions [Hash] API key permission settings. Bybit V5 expects
      #   PascalCase group keys — e.g. `{ 'ContractTrade' => ['Order'], 'Spot' => ['Order'], 'Wallet' => ['AccountTransfer'] }`.
      #   The SDK passes this hash through VERBATIM (no snake→camel conversion)
      #   so callers must use the docs-spelling of each group name.
      # @option kwargs [String] :ips Bound IP addresses (comma-separated)
      # @option kwargs [String] :note API key note
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/create-subuid-apikey
      def create_sub_api_key(subuid:, read_only:, permissions:, **kwargs)
        params = kwargs.merge(subuid: subuid, read_only: read_only)
        params = Bybit::Utils::WireKeys.camelize(params)
        # `permissions` is intentionally re-attached AFTER camelize — Bybit V5
        # wants PascalCase group keys (ContractTrade / Spot / Wallet / ...)
        # which a naive snake→camel pass would corrupt.
        params[:permissions] = permissions
        @session.sign_request(method: :post, path: '/v5/user/create-sub-api', body: params)
      end

      # Create Sub UID.
      #
      # POST /v5/user/create-sub-member
      #
      # @param username [String] Sub-account username
      # @param member_type [Integer] Sub-account type (1: normal, 6: custodial)
      # @option kwargs [String] :password Sub-account login password
      # @option kwargs [Integer] :switch Quick login toggle
      # @option kwargs [Boolean] :is_uta Whether to create as UTA account
      # @option kwargs [String] :note Sub-account note
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/create-subuid
      def create_sub_member(username:, member_type:, **kwargs)
        params = kwargs.merge(username: username, member_type: member_type)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/create-sub-member', body: params)
      end

      # Delete Master API Key.
      #
      # POST /v5/user/delete-api
      #
      # @option kwargs [String] :apikey API key to delete
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/rm-master-apikey
      def delete_api_key(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/delete-api', body: params)
      end

      # Delete Sub-account API Key.
      #
      # POST /v5/user/delete-sub-api
      #
      # @param subuid [Integer] Sub UID
      # @option kwargs [String] :apikey Sub-account API key to delete
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/rm-sub-apikey
      def delete_sub_api_key(subuid:, **kwargs)
        params = kwargs.merge(subuid: subuid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/delete-sub-api', body: params)
      end

      # Delete Sub-account.
      #
      # POST /v5/user/del-submember
      #
      # @param subuid [Integer] Sub UID to delete
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def delete_sub_member(subuid:, **kwargs)
        params = kwargs.merge(subuid: subuid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/del-submember', body: params)
      end

      # Freeze or unfreeze a Sub UID.
      #
      # POST /v5/user/frozen-sub-member
      #
      # @param subuid [Integer] Sub UID
      # @param frozen [Integer] Freeze flag (0: unfreeze, 1: freeze)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/froze-subuid
      def frozen_sub_member(subuid:, frozen:, **kwargs)
        params = kwargs.merge(subuid: subuid, frozen: frozen)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/frozen-sub-member', body: params)
      end

      # Get Affiliate User Info.
      #
      # GET /v5/user/aff-customer-info
      #
      # @param uid [String] Affiliate user UID
      # @option kwargs [String] :coin Coin filter
      # @option kwargs [String] :business Business type filter
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_affiliate_custom_open_info(uid:, **kwargs)
        params = kwargs.merge(uid: uid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/aff-customer-info', params: params)
      end

      # Get Member Account Type.
      #
      # GET /v5/user/get-member-type
      #
      # @option kwargs [String] :member_ids Comma-separated member IDs
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def get_member_account_type(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/get-member-type', params: params)
      end

      # List Sub-account API Keys.
      #
      # GET /v5/user/sub-apikeys
      #
      # @param subuid [Integer] Sub UID
      # @option kwargs [Integer] :limit Page limit
      # @option kwargs [String] :cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/list-sub-apikeys
      def list_sub_api_keys(subuid:, **kwargs)
        params = kwargs.merge(subuid: subuid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/sub-apikeys', params: params)
      end

      # Get API Key Information.
      #
      # GET /v5/user/query-api
      #
      # @see https://bybit-exchange.github.io/docs/v5/user/apikey-info
      def get_api_key_info
        @session.sign_request(method: :get, path: '/v5/user/query-api')
      end

      # Query Escrow Sub-accounts (Fund Management).
      #
      # GET /v5/user/escrow_sub_members
      #
      # @option kwargs [Integer] :next_cursor Pagination cursor
      # @option kwargs [Integer] :page_size Page size
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_escrow_sub_members(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/escrow_sub_members', params: params)
      end

      # Query Referrals.
      #
      # GET /v5/user/invitation/referrals
      #
      # @option kwargs [String] :cursor Pagination cursor
      # @option kwargs [Integer] :size Page size
      # @option kwargs [String] :status Referral status filter
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_referrals(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/invitation/referrals', params: params)
      end

      # Query Sub UID List.
      #
      # GET /v5/user/query-sub-members
      #
      # @see https://bybit-exchange.github.io/docs/v5/user/subuid-list
      def list_sub_member_uids
        @session.sign_request(method: :get, path: '/v5/user/query-sub-members')
      end

      # List Sub-accounts (paginated variant — /v5/user/submembers).
      # Distinct from #list_sub_member_uids (/v5/user/query-sub-members).
      #
      # GET /v5/user/submembers
      #
      # @option kwargs [Integer] :page_size Page size
      # @option kwargs [Integer] :next_cursor Pagination cursor
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def list_sub_members(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/submembers', params: params)
      end

      # Sign Agreement
      #
      # POST /v5/user/agreement
      #
      # @param category [Integer] Agreement category
      # @param agree [Boolean] Whether to agree
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      def sign_agreement(category:, agree:, **kwargs)
        params = kwargs.merge(category: category, agree: agree)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/agreement', body: params)
      end

      # Modify Master API Key
      #
      # POST /v5/user/update-api
      #
      # @option kwargs [Integer] :read_only Read-only flag
      # @option kwargs [String] :ips Bound IP list
      # @option kwargs [Hash] :permissions Permissions object
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/modify-master-apikey
      def update_api_key(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/update-api', body: params)
      end

      # Modify Sub-account API Key
      #
      # POST /v5/user/update-sub-api
      #
      # @param subuid [Integer] Sub UID
      # @param read_only [Integer] Read-only flag
      # @option kwargs [String] :apikey Sub-account API key
      # @option kwargs [String] :ips Bound IP list
      # @option kwargs [Hash] :permissions Permissions object. Bybit V5 expects
      #   PascalCase group keys (`ContractTrade` / `Spot` / `Wallet` / ...). This
      #   hash is passed through VERBATIM — no snake→camel conversion.
      # @option kwargs [String] :note Note
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/user/modify-sub-apikey
      def update_sub_api_key(subuid:, read_only:, **kwargs)
        permissions = kwargs.delete(:permissions)
        params = kwargs.merge(subuid: subuid, read_only: read_only)
        params = Bybit::Utils::WireKeys.camelize(params)
        # See `create_sub_api_key` — permissions is re-attached AFTER camelize
        # so PascalCase group keys survive the wire trip intact.
        params[:permissions] = permissions unless permissions.nil?
        @session.sign_request(method: :post, path: '/v5/user/update-sub-api', body: params)
      end
    end
  end
end
