# frozen_string_literal: true

# gen-sdk-ruby:service-requires:start
require 'bybit/rest_api/account_service'
require 'bybit/rest_api/affiliate_service'
require 'bybit/rest_api/asset_service'
require 'bybit/rest_api/bot_service'
require 'bybit/rest_api/broker_service'
require 'bybit/rest_api/crypto_loan_service'
require 'bybit/rest_api/earn_service'
require 'bybit/rest_api/institutional_loan_service'
require 'bybit/rest_api/market_service'
require 'bybit/rest_api/misc_service'
require 'bybit/rest_api/p2p_service'
require 'bybit/rest_api/position_service'
require 'bybit/rest_api/pre_upgrade_service'
require 'bybit/rest_api/rfq_service'
require 'bybit/rest_api/spot_margin_service'
require 'bybit/rest_api/trade_service'
require 'bybit/rest_api/user_service'
require 'bybit/rest_api/alpha_service'
require 'bybit/rest_api/event_service'
require 'bybit/rest_api/fiat_service'
require 'bybit/rest_api/referral_service'
require 'bybit/rest_api/spot_x_service'
require 'bybit/rest_api/spread_trade_service'
require 'bybit/rest_api/strategy_service'
require 'bybit/rest_api/tax_service'
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
    attr_reader :account, :affiliate, :alpha, :asset, :bot, :broker, :crypto_loan, :earn,
                :event, :fiat, :institutional_loan, :market, :misc, :p2p, :position,
                :pre_upgrade, :referral, :rfq, :spot_margin, :spot_x, :spread_trade,
                :strategy, :tax, :trade, :user

    # gen-sdk-ruby:client-readers:end

    def initialize(config = nil, **overrides)
      cfg = (config || Bybit.configuration).dup
      overrides.each { |k, v| cfg.public_send("#{k}=", v) }
      session = Session.new(cfg)
      @config = cfg

      # gen-sdk-ruby:client-inits:start
      {
        account: RestApi::AccountService,
        affiliate: RestApi::AffiliateService,
        alpha: RestApi::AlphaService,
        asset: RestApi::AssetService,
        bot: RestApi::BotService,
        broker: RestApi::BrokerService,
        crypto_loan: RestApi::CryptoLoanService,
        earn: RestApi::EarnService,
        event: RestApi::EventService,
        fiat: RestApi::FiatService,
        institutional_loan: RestApi::InstitutionalLoanService,
        market: RestApi::MarketService,
        misc: RestApi::MiscService,
        p2p: RestApi::P2pService,
        position: RestApi::PositionService,
        pre_upgrade: RestApi::PreUpgradeService,
        referral: RestApi::ReferralService,
        rfq: RestApi::RfqService,
        spot_margin: RestApi::SpotMarginService,
        spot_x: RestApi::SpotXService,
        spread_trade: RestApi::SpreadTradeService,
        strategy: RestApi::StrategyService,
        tax: RestApi::TaxService,
        trade: RestApi::TradeService,
        user: RestApi::UserService
      }.each do |name, service_class|
        instance_variable_set("@#{name}", service_class.new(session))
      end
      # gen-sdk-ruby:client-inits:end
    end

    # Redacted #inspect so console printing doesn't leak the secret.
    def inspect
      "#<Bybit::Client testnet=#{@config.testnet} base_url=#{@config.resolved_base_url}>"
    end
    alias to_s inspect
  end
end
