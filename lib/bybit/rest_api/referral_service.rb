# frozen_string_literal: true

module Bybit
  module RestApi
    class ReferralService < BaseService
      # Get referral rules and campaign task rewards for the current site
      #
      # POST /v5/referral/campaign/rewards
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/referral/referral-campaign-rewards
      def get_campaign_rewards
        @session.sign_request(method: :post, path: '/v5/referral/campaign/rewards')
      end

      # Get Referral Commission Records
      #
      # POST /v5/referral/commission/records
      #
      # @option kwargs [Array] :user_id_list Invitee ID list; an empty list does not filter by invitee.
      # @option kwargs [String] :start_time Query start time in YYYY-MM-DD HH:mm:ss format; an invalid value is passed downstream as an empty string, whose handling is unverified.
      # @option kwargs [String] :end_time Query end time in YYYY-MM-DD HH:mm:ss format; an invalid value is passed downstream as an empty string, whose handling is unverified.
      # @option kwargs [Integer] :page One-based page number; 0 is treated as 1.
      # @option kwargs [Integer] :page_size Number of records per page; 0 or a value greater than 200 is treated as 10.
      # @option kwargs [Integer] :product_line Product lines: 0=unknown; 1=spot; 2=contracts; 3=options; 4=USDC perpetual; 6=TradeFi; 9=Alpha. Unrecognized downstream product lines map to 0.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/referral/referral-commission-records
      def get_commission_records(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/referral/commission/records', body: params)
      end

      # Get Referral User Identity Profile
      #
      # POST /v5/referral/user/identity-profile
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/referral/referral-user-identity-profile
      def get_user_identity_profile
        @session.sign_request(method: :post, path: '/v5/referral/user/identity-profile')
      end

      # Get referral user invitations
      #
      # POST /v5/referral/user/invitations
      #
      # @option kwargs [Array] :user_id_list
      # @option kwargs [String] :start_time Recommended format: YYYY-MM-DD HH:mm:ss; invalid or empty values are passed downstream as 0.
      # @option kwargs [String] :end_time Recommended format: YYYY-MM-DD HH:mm:ss; invalid or empty values are passed downstream as 0.
      # @option kwargs [Integer] :page
      # @option kwargs [Integer] :page_size Values 0 and greater than 200 are reset to 10 by the current service implementation.
      # @option kwargs [Integer] :friend_status
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/referral/referral-user-invitations
      def get_user_invitations(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/referral/user/invitations', body: params)
      end
    end
  end
end
