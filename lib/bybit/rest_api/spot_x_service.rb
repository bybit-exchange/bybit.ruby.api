# frozen_string_literal: true

module Bybit
  module RestApi
    class SpotXService < BaseService
      # Get Launchpool project (activity) list
      #
      # GET /v5/spot-x/launchpool/project/list
      #
      # @param status [Integer] Activity phase filter.
      #   - `0` — Upcoming
      #   - `1` — Ongoing
      #   - `2` — Ended
      # @option kwargs [String] :activity_coin Filter by activity (reward) coin symbol (case-insensitive), e.g. `BTC`, `ETH`.
      # @option kwargs [String] :project_id Exact activity code. Use to query a single project.
      # @option kwargs [String] :cursor Pagination cursor returned as `nextPageCursor` in the previous response. Omit for the first page.
      # @option kwargs [Integer] :limit Number of items per page. Defaults to `10`. Maximum `10`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/launchpool/project/list
      def get_launchpool_project_list(status:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(status: status))
        @session.public_request(path: '/v5/spot-x/launchpool/project/list', params: params)
      end

      # Get user's staking operation records
      #
      # POST /v5/spot-x/launchpool/user/activity-log
      #
      # @option kwargs [String] :stake_coin Filter by stake coin symbol (case-sensitive).
      # @option kwargs [Integer] :type Filter by operation type. Omit to return all types.
      #   - `0` PLEDGE — manual stake-in
      #   - `1` REDEEM — manual redeem
      #   - `2` INTEREST — reward/interest credit
      #   - `3` AUTO_REDEEM — auto principal return on maturity
      #   - `4` LOAN_PLEDGE — leveraged stake-in
      #   - `5` LOAN_REDEEM — manual leveraged redeem
      #   - `6` LOAN_AUTO_REDEEM — auto leveraged maturity redemption
      #   - `7` LOAN_RISKRATE_AUTO_REDEEM — leveraged liquidation
      #   - `8` RISK_USER_AUTO_REDEEM — risk-control forced redeem (non-leveraged)
      #   - `9` LOAN_RISK_USER_AUTO_REDEEM — risk-control forced redeem (leveraged)
      #   - `10` EARN_REWARD — earn product reward credit
      # @option kwargs [Integer] :status Filter by record status. Omit to return all statuses.
      #   - `0` — Pending
      #   - `1` — Success
      #   - `2` — Failed
      # @option kwargs [String] :start_time Query start time — 13-digit Unix millisecond timestamp string.
      #   Must be provided together with `endTime`.
      # @option kwargs [String] :end_time Query end time — 13-digit Unix millisecond timestamp string.
      #   Must be provided together with `startTime`.
      # @option kwargs [Integer] :page_size Number of records per page. Defaults to `10`. Maximum `10`.
      # @option kwargs [Integer] :current Page number (1-based). Defaults to `1`. Maximum `100`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/launchpool/user/activity-log
      def get_launchpool_user_activity_log(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/spot-x/launchpool/user/activity-log', body: params)
      end

      # Get user's active staking positions
      #
      # GET /v5/spot-x/launchpool/user/current-staking
      #
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/launchpool/user/current-staking
      def get_launchpool_user_current_staking
        @session.sign_request(method: :get, path: '/v5/spot-x/launchpool/user/current-staking')
      end

      # Get user's completed staking position history
      #
      # POST /v5/spot-x/launchpool/user/history
      #
      # @option kwargs [String] :stake_coin Filter by stake coin symbol.
      # @option kwargs [String] :reward_coin Filter by reward coin symbol.
      # @option kwargs [String] :start_time Staking period start filter — 13-digit Unix millisecond timestamp string.
      #   Filters positions whose `stakeBeginTime` is on or after this value.
      #   Must be provided together with `endTime`.
      # @option kwargs [String] :end_time Staking period end filter — 13-digit Unix millisecond timestamp string.
      #   Filters positions whose `stakeEndTime` is on or before this value.
      #   Must be provided together with `startTime`.
      # @option kwargs [Integer] :page_size Number of records per page. Defaults to `10`. Maximum `10`.
      # @option kwargs [Integer] :current Page number (1-based). Defaults to `1`. Maximum `100`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/launchpool/user/history
      def get_launchpool_user_history(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :post, path: '/v5/spot-x/launchpool/user/history', body: params)
      end

      # Get Puzzle project (activity) list
      #
      # GET /v5/spot-x/puzzle/project/list
      #
      # @param status [Integer] Activity phase filter.
      #   - `0` — Upcoming (not yet started)
      #   - `1` — Ongoing (in progress)
      #   - `2` — Ended
      # @option kwargs [String] :project_id Exact activity code (unique project identifier). Use to query a single project.
      # @option kwargs [String] :activity_coin Filter by activity coin symbol (case-insensitive), e.g. `BTC`, `ETH`.
      # @option kwargs [String] :cursor Pagination cursor returned as `nextPageCursor` in the previous response. Omit for the first page.
      # @option kwargs [Integer] :limit Number of items per page. Defaults to `10`. Maximum `10`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/puzzle/project/list
      def get_puzzle_project_list(status:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(status: status))
        @session.public_request(path: '/v5/spot-x/puzzle/project/list', params: params)
      end

      # Get Token Splash project (activity) list
      #
      # GET /v5/spot-x/token-splash/project/list
      #
      # @param status [Integer] Activity phase filter.
      #   - `0` — Upcoming (registration not yet started)
      #   - `1` — Ongoing (activity in progress)
      #   - `2` — Ended (announcement time has passed)
      # @option kwargs [String] :project_id Exact activity code. Use to query a single project.
      # @option kwargs [String] :activity_coin Filter by activity coin symbol (case-insensitive), e.g. `BTC`, `ETH`.
      # @option kwargs [String] :cursor Pagination cursor returned as `nextPageCursor` in the previous response. Omit for the first page.
      # @option kwargs [Integer] :limit Number of items per page. Defaults to `10`. Maximum `10`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/token-splash/project/list
      def get_token_splash_project_list(status:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(status: status))
        @session.public_request(path: '/v5/spot-x/token-splash/project/list', params: params)
      end

      # Get user's Token Splash trade-task progress
      #
      # GET /v5/spot-x/token-splash/user/activity-params
      #
      # @option kwargs [String] :project_id Filter by exact activity code. Returns data for a single project when provided.
      # @option kwargs [String] :activity_coin Filter by activity coin symbol (case-insensitive), e.g. `BTC`, `ETH`.
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/spot-x/token-splash/user/activity-params
      def get_token_splash_user_activity_params(**kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs)
        @session.sign_request(method: :get, path: '/v5/spot-x/token-splash/user/activity-params', params: params)
      end
    end
  end
end
