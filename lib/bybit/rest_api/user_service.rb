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
      # @param permissions [Hash] API key permission settings
      # @option kwargs [String] :ips Bound IP addresses (comma-separated)
      # @option kwargs [String] :note API key note
      # @see https://bybit-exchange.github.io/docs/v5/user/create-subuid-apikey
      def create_sub_api_key(subuid:, read_only:, permissions:, **kwargs)
        params = kwargs.merge(subuid: subuid, read_only: read_only, permissions: permissions)
        params = Bybit::Utils::WireKeys.camelize(params)
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
      def delete_sub_member_v5(subuid:, **kwargs)
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
      def get_affiliate_custom_open_info_v5(uid:, **kwargs)
        params = kwargs.merge(uid: uid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/aff-customer-info', params: params)
      end

      # Get Member Account Type.
      #
      # GET /v5/user/get-member-type
      #
      # @option kwargs [String] :member_ids Comma-separated member IDs
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
      # @see https://bybit-exchange.github.io/docs/v5/user/list-sub-apikeys
      def list_sub_api_keys_v5(subuid:, **kwargs)
        params = kwargs.merge(subuid: subuid)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/sub-apikeys', params: params)
      end

      # Get API Key Information.
      #
      # GET /v5/user/query-api
      #
      # @see https://bybit-exchange.github.io/docs/v5/user/apikey-info
      def query_api_key
        @session.sign_request(method: :get, path: '/v5/user/query-api')
      end

      # Query Escrow Sub-accounts (Fund Management).
      #
      # GET /v5/user/escrow_sub_members
      #
      # @option kwargs [Integer] :next_cursor Pagination cursor
      # @option kwargs [Integer] :page_size Page size
      def query_escrow_sub_members_v5(**kwargs)
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
      def query_referrals(**kwargs)
        params = kwargs.dup
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :get, path: '/v5/user/invitation/referrals', params: params)
      end

      # Query Sub UID List.
      #
      # GET /v5/user/query-sub-members
      #
      # @see https://bybit-exchange.github.io/docs/v5/user/subuid-list
      def query_sub_members
        @session.sign_request(method: :get, path: '/v5/user/query-sub-members')
      end

      # Query Sub-accounts List.
      #
      # GET /v5/user/submembers
      #
      # @option kwargs [Integer] :page_size Page size
      # @option kwargs [Integer] :next_cursor Pagination cursor
      def query_sub_members_v5(**kwargs)
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
      # @option kwargs [Hash] :permissions Permissions object
      # @option kwargs [String] :note Note
      # @see https://bybit-exchange.github.io/docs/v5/user/modify-sub-apikey
      def update_sub_api_key(subuid:, read_only:, **kwargs)
        params = kwargs.merge(subuid: subuid, read_only: read_only)
        params = Bybit::Utils::WireKeys.camelize(params)
        @session.sign_request(method: :post, path: '/v5/user/update-sub-api', body: params)
      end
    end
  end
end
