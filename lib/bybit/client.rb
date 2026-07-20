# frozen_string_literal: true

# gen-sdk-ruby:service-requires:start
require 'bybit/rest_api/account_service'
require 'bybit/rest_api/affiliate_service'
require 'bybit/rest_api/asset_service'
require 'bybit/rest_api/bot_service'
require 'bybit/rest_api/broker_service'
require 'bybit/rest_api/crypto_loan_service'
require 'bybit/rest_api/earn_service'
require 'bybit/rest_api/market_service'
require 'bybit/rest_api/p2p_service'
require 'bybit/rest_api/position_service'
require 'bybit/rest_api/rfq_service'
require 'bybit/rest_api/spot_margin_service'
require 'bybit/rest_api/trade_service'
require 'bybit/rest_api/user_service'
# gen-sdk-ruby:service-requires:end

module Bybit
  # Global configuration block — Bybit.configure { |c| c.api_key = ... }
  class << self
    attr_writer :configuration
    def configuration
      @configuration ||= Configuration.new
    end
    def configure
      yield configuration
    end
  end

  class Client
    # gen-sdk-ruby:client-readers:start
    attr_reader :account
    attr_reader :affiliate
    attr_reader :asset
    attr_reader :bot
    attr_reader :broker
    attr_reader :crypto_loan
    attr_reader :earn
    attr_reader :market
    attr_reader :p2p
    attr_reader :position
    attr_reader :rfq
    attr_reader :spot_margin
    attr_reader :trade
    attr_reader :user
    # gen-sdk-ruby:client-readers:end

    def initialize(config = nil, **overrides)
      cfg = (config || Bybit.configuration).dup
      overrides.each { |k, v| cfg.public_send("#{k}=", v) }
      session = Session.new(cfg)
      @config = cfg

      # gen-sdk-ruby:client-inits:start
      @account = RestApi::AccountService.new(session)
      @affiliate = RestApi::AffiliateService.new(session)
      @asset = RestApi::AssetService.new(session)
      @bot = RestApi::BotService.new(session)
      @broker = RestApi::BrokerService.new(session)
      @crypto_loan = RestApi::CryptoLoanService.new(session)
      @earn = RestApi::EarnService.new(session)
      @market = RestApi::MarketService.new(session)
      @p2p = RestApi::P2pService.new(session)
      @position = RestApi::PositionService.new(session)
      @rfq = RestApi::RfqService.new(session)
      @spot_margin = RestApi::SpotMarginService.new(session)
      @trade = RestApi::TradeService.new(session)
      @user = RestApi::UserService.new(session)
      # gen-sdk-ruby:client-inits:end
    end

    # Redacted #inspect so console printing doesn't leak the secret.
    def inspect
      "#<Bybit::Client testnet=#{@config.testnet} base_url=#{@config.resolved_base_url}>"
    end
    alias_method :to_s, :inspect
  end
end
