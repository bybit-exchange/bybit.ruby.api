# frozen_string_literal: true

RSpec.describe 'generated REST API contracts' do
  # gen-sdk-ruby:generated-service-specs:start
  # endpoint: GET /v5/alpha/prediction/engine-status
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/alpha/prediction/engine-status'
    )
    service.get_prediction_engine_status
  end

  # endpoint: GET /v5/alpha/prediction/pay-token-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/alpha/prediction/pay-token-list'
    )
    service.get_prediction_pay_token_list
  end

  # endpoint: GET /v5/alpha/prediction/sports/timeline-stages
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/alpha/prediction/sports/timeline-stages',
      params: { eventType: 'event_type-value' }
    )
    service.get_prediction_timeline_stages(event_type: 'event_type-value')
  end

  # endpoint: GET /v5/event/order-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::EventService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/event/order-list',
      params: {
        symbol: 'symbol-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        startTime: 1,
        endTime: 1,
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_ec_order_history(
      symbol: 'symbol-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      start_time: 1,
      end_time: 1,
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/event/order-realtime
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::EventService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/event/order-realtime',
      params: {
        symbol: 'symbol-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_ec_active_orders(
      symbol: 'symbol-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/event/positions
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::EventService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/event/positions',
      params: {
        symbol: 'symbol-value',
        baseCoin: 'base_coin-value',
        settleCoin: 'settle_coin-value',
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_ec_position_info(
      symbol: 'symbol-value',
      base_coin: 'base_coin-value',
      settle_coin: 'settle_coin-value',
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/event/settlements
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::EventService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/event/settlements',
      params: {
        symbol: 'symbol-value',
        orderId: 'order_id-value',
        startTime: 1,
        endTime: 1,
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_ec_settlements(
      symbol: 'symbol-value',
      order_id: 'order_id-value',
      start_time: 1,
      end_time: 1,
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/event/trades
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::EventService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/event/trades',
      params: {
        symbol: 'symbol-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        startTime: 1,
        endTime: 1,
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_ec_trade_history(
      symbol: 'symbol-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      start_time: 1,
      end_time: 1,
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/fht/compliance/tax/private/batch_query
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::TaxService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/fht/compliance/tax/private/batch_query',
      params: { batchId: 'batch_id-value' }
    )
    service.batch_query_tax_reports(batch_id: 'batch_id-value')
  end

  # endpoint: GET /v5/fiat/balance-query
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/fiat/balance-query',
      params: { accountCategory: 'fiat', currency: 'currency-value' }
    )
    service.query_balance(account_category: 'fiat', currency: 'currency-value')
  end

  # endpoint: GET /v5/fiat/query-coin-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/fiat/query-coin-list',
      params: { side: 0 }
    )
    service.query_coin_list(side: 0)
  end

  # endpoint: GET /v5/fiat/query-trade-history
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/fiat/query-trade-history',
      params: { index: 1, limit: 1, startTime: 'start_time-value', endTime: 'end_time-value' }
    )
    service.query_trade_history(
      index: 1,
      limit: 1,
      start_time: 'start_time-value',
      end_time: 'end_time-value'
    )
  end

  # endpoint: GET /v5/fiat/reference-price
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/fiat/reference-price',
      params: { symbol: 'symbol-value', paymentMethod: 'payment_method-value' }
    )
    service.get_reference_price(symbol: 'symbol-value', payment_method: 'payment_method-value')
  end

  # endpoint: GET /v5/fiat/trade-query
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/fiat/trade-query',
      params: { tradeNo: 'trade_no-value', merchantRequestId: 'merchant_request_id-value' }
    )
    service.query_trade(
      trade_no: 'trade_no-value',
      merchant_request_id: 'merchant_request_id-value'
    )
  end

  # endpoint: GET /v5/ins-loan/coin-delta-amount
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::InstitutionalLoanService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/ins-loan/coin-delta-amount',
      params: { coin: 'coin-value' }
    )
    service.ins_loan_coin_delta_amount(coin: 'coin-value')
  end

  # endpoint: GET /v5/ins-loan/delay-liq-status
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::InstitutionalLoanService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/ins-loan/delay-liq-status'
    )
    service.ins_loan_delay_liq_status
  end

  # endpoint: GET /v5/spot-margin-trade/fixedborrow-interest-accrued
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotMarginService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spot-margin-trade/fixedborrow-interest-accrued',
      params: {
        orderId: 'order_id-value',
        orderCurrency: 'order_currency-value',
        limit: 'limit-value',
        cursor: 'cursor-value'
      }
    )
    service.query_fixed_borrow_penalty_interest(
      order_id: 'order_id-value',
      order_currency: 'order_currency-value',
      limit: 'limit-value',
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/spot-x/launchpool/project/list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spot-x/launchpool/project/list',
      params: {
        status: 1,
        activityCoin: 'activity_coin-value',
        projectId: 'project_id-value',
        cursor: 'cursor-value',
        limit: 1
      }
    )
    service.get_launchpool_project_list(
      status: 1,
      activity_coin: 'activity_coin-value',
      project_id: 'project_id-value',
      cursor: 'cursor-value',
      limit: 1
    )
  end

  # endpoint: GET /v5/spot-x/launchpool/user/current-staking
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spot-x/launchpool/user/current-staking'
    )
    service.get_launchpool_user_current_staking
  end

  # endpoint: GET /v5/spot-x/puzzle/project/list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spot-x/puzzle/project/list',
      params: {
        status: 1,
        projectId: 'project_id-value',
        activityCoin: 'activity_coin-value',
        cursor: 'cursor-value',
        limit: 1
      }
    )
    service.get_puzzle_project_list(
      status: 1,
      project_id: 'project_id-value',
      activity_coin: 'activity_coin-value',
      cursor: 'cursor-value',
      limit: 1
    )
  end

  # endpoint: GET /v5/spot-x/token-splash/project/list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spot-x/token-splash/project/list',
      params: {
        status: 1,
        projectId: 'project_id-value',
        activityCoin: 'activity_coin-value',
        cursor: 'cursor-value',
        limit: 1
      }
    )
    service.get_token_splash_project_list(
      status: 1,
      project_id: 'project_id-value',
      activity_coin: 'activity_coin-value',
      cursor: 'cursor-value',
      limit: 1
    )
  end

  # endpoint: GET /v5/spot-x/token-splash/user/activity-params
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spot-x/token-splash/user/activity-params',
      params: { projectId: 'project_id-value', activityCoin: 'activity_coin-value' }
    )
    service.get_token_splash_user_activity_params(
      project_id: 'project_id-value',
      activity_coin: 'activity_coin-value'
    )
  end

  # endpoint: GET /v5/spread/execution/list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spread/execution/list',
      params: {
        symbol: 'symbol-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        startTime: 1,
        endTime: 1,
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_history(
      symbol: 'symbol-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      start_time: 1,
      end_time: 1,
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/spread/instrument
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spread/instrument',
      params: { symbol: 'symbol-value', baseCoin: 'base_coin-value', limit: 1, cursor: 'cursor-value' }
    )
    service.get_spread_instruments_info(
      symbol: 'symbol-value',
      base_coin: 'base_coin-value',
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/spread/max-qty
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spread/max-qty',
      params: { symbol: 'symbol-value', side: '1', orderPrice: 'order_price-value' }
    )
    service.get_spread_max_qty(symbol: 'symbol-value', side: '1', order_price: 'order_price-value')
  end

  # endpoint: GET /v5/spread/order/history
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spread/order/history',
      params: {
        symbol: 'symbol-value',
        baseCoin: 'base_coin-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        startTime: 1,
        endTime: 1,
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_spread_order_history(
      symbol: 'symbol-value',
      base_coin: 'base_coin-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      start_time: 1,
      end_time: 1,
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/spread/order/realtime
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/spread/order/realtime',
      params: {
        symbol: 'symbol-value',
        baseCoin: 'base_coin-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        limit: 1,
        cursor: 'cursor-value'
      }
    )
    service.get_spread_open_orders(
      symbol: 'symbol-value',
      base_coin: 'base_coin-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      limit: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/spread/orderbook
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spread/orderbook',
      params: { symbol: 'symbol-value', limit: 1 }
    )
    service.get_spread_orderbook(symbol: 'symbol-value', limit: 1)
  end

  # endpoint: GET /v5/spread/recent-trade
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spread/recent-trade',
      params: { symbol: 'symbol-value', limit: 1 }
    )
    service.get_spread_recent_trades(symbol: 'symbol-value', limit: 1)
  end

  # endpoint: GET /v5/spread/tickers
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:public_request).with(
      path: '/v5/spread/tickers',
      params: { symbol: 'symbol-value' }
    )
    service.get_spread_tickers(symbol: 'symbol-value')
  end

  # endpoint: GET /v5/strategy/list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::StrategyService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/strategy/list',
      params: {
        strategyId: 'strategy_id-value',
        status: '2',
        symbol: 'symbol-value',
        category: 'UTA_USDT',
        strategyType: 'twap',
        beginTimeE0: 1,
        endTimeE0: 1,
        pageSize: 1,
        cursor: 'cursor-value'
      }
    )
    service.query_list(
      strategy_id: 'strategy_id-value',
      status: '2',
      symbol: 'symbol-value',
      category: 'UTA_USDT',
      strategy_type: 'twap',
      begin_time_e0: 1,
      end_time_e0: 1,
      page_size: 1,
      cursor: 'cursor-value'
    )
  end

  # endpoint: GET /v5/strategy/order-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::StrategyService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :get,
      path: '/v5/strategy/order-list',
      params: {
        strategyId: 'strategy_id-value',
        status: '1',
        symbol: 'symbol-value',
        beginTimeE0: 1,
        endTimeE0: 1,
        pageSize: 1,
        cursor: 'cursor-value',
        strategyType: 'twap'
      }
    )
    service.query_order_list(
      strategy_id: 'strategy_id-value',
      status: '1',
      symbol: 'symbol-value',
      begin_time_e0: 1,
      end_time_e0: 1,
      page_size: 1,
      cursor: 'cursor-value',
      strategy_type: 'twap'
    )
  end

  # endpoint: POST /v5/alpha/lp/order-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/order-list',
      body: {
        orderType: 0,
        tokenCode: 'token_code-value',
        orderStatus: ['order_status-value'],
        days: 1,
        limit: 1,
        pageIndex: 1,
        poolAddress: 'pool_address-value'
      }
    )
    service.get_lp_order_list(
      order_type: 0,
      token_code: 'token_code-value',
      order_status: ['order_status-value'],
      days: 1,
      limit: 1,
      page_index: 1,
      pool_address: 'pool_address-value'
    )
  end

  # endpoint: POST /v5/alpha/lp/pay-token-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/pay-token-list',
      body: { chainCode: 'chain_code-value', tokenAddress: 'token_address-value' }
    )
    service.get_lp_pay_token_list(
      chain_code: 'chain_code-value',
      token_address: 'token_address-value'
    )
  end

  # endpoint: POST /v5/alpha/lp/pay-token-price
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/pay-token-price',
      body: { tokenCode: ['token_code-value'], chainCode: 'chain_code-value' }
    )
    service.get_lp_pay_token_price(token_code: ['token_code-value'], chain_code: 'chain_code-value')
  end

  # endpoint: POST /v5/alpha/lp/pool-info
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/pool-info',
      body: { poolAddress: 'pool_address-value' }
    )
    service.get_lp_pool_info(pool_address: 'pool_address-value')
  end

  # endpoint: POST /v5/alpha/lp/pool-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/pool-list',
      body: { tokenSymbol: 'token_symbol-value' }
    )
    service.get_lp_pool_list(token_symbol: 'token_symbol-value')
  end

  # endpoint: POST /v5/alpha/lp/position-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/position-list'
    )
    service.get_lp_position_list
  end

  # endpoint: POST /v5/alpha/lp/redeem
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/redeem',
      body: {
        positionId: 1,
        poolAddress: 'pool_address-value',
        dercRatio: 'derc_ratio-value',
        receiveTokenCode: 'receive_token_code-value'
      }
    )
    service.execute_lp_redeem(
      position_id: 1,
      pool_address: 'pool_address-value',
      derc_ratio: 'derc_ratio-value',
      receive_token_code: 'receive_token_code-value'
    )
  end

  # endpoint: POST /v5/alpha/lp/stake
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/lp/stake',
      body: {
        positionId: 1,
        poolAddress: 'pool_address-value',
        payTokenAmount: 'pay_token_amount-value',
        payTokenCode: 'pay_token_code-value',
        rangeUpper: 'range_upper-value',
        rangeLower: 'range_lower-value',
        priceUpper: 'price_upper-value',
        priceLower: 'price_lower-value'
      }
    )
    service.execute_lp_stake(
      position_id: 1,
      pool_address: 'pool_address-value',
      pay_token_amount: 'pay_token_amount-value',
      pay_token_code: 'pay_token_code-value',
      range_upper: 'range_upper-value',
      range_lower: 'range_lower-value',
      price_upper: 'price_upper-value',
      price_lower: 'price_lower-value'
    )
  end

  # endpoint: POST /v5/alpha/prediction/buy
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/buy',
      body: {
        tokenId: 'token_id-value',
        amount: 'amount-value',
        payTokenCode: 'pay_token_code-value',
        orderType: 'order_type-value',
        slippage: 'slippage-value',
        eventId: 'event_id-value'
      }
    )
    service.execute_prediction_buy(
      token_id: 'token_id-value',
      amount: 'amount-value',
      pay_token_code: 'pay_token_code-value',
      order_type: 'order_type-value',
      slippage: 'slippage-value',
      event_id: 'event_id-value'
    )
  end

  # endpoint: POST /v5/alpha/prediction/event-detail
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/event-detail',
      body: { eventId: 'event_id-value', slug: 'slug-value', hasMoreMarkets: true }
    )
    service.get_prediction_event_detail(
      event_id: 'event_id-value',
      slug: 'slug-value',
      has_more_markets: true
    )
  end

  # endpoint: POST /v5/alpha/prediction/order-book
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/order-book',
      body: { tokenIds: ['token_ids-value'] }
    )
    service.get_prediction_order_book(token_ids: ['token_ids-value'])
  end

  # endpoint: POST /v5/alpha/prediction/order-estimate
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/order-estimate',
      body: {
        tokenId: 'token_id-value',
        side: 'side-value',
        eventId: 'event_id-value',
        amount: 'amount-value',
        orderType: 'order_type-value',
        payTokenCode: 'pay_token_code-value'
      }
    )
    service.get_prediction_order_estimate(
      token_id: 'token_id-value',
      side: 'side-value',
      event_id: 'event_id-value',
      amount: 'amount-value',
      order_type: 'order_type-value',
      pay_token_code: 'pay_token_code-value'
    )
  end

  # endpoint: POST /v5/alpha/prediction/order-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/order-list',
      body: {
        status: 'status-value',
        tokenId: 'token_id-value',
        limit: 1,
        pageIndex: 1,
        eventId: 'event_id-value',
        side: 'side-value',
        days: 1
      }
    )
    service.get_prediction_order_list(
      status: 'status-value',
      token_id: 'token_id-value',
      limit: 1,
      page_index: 1,
      event_id: 'event_id-value',
      side: 'side-value',
      days: 1
    )
  end

  # endpoint: POST /v5/alpha/prediction/portfolio-summary
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/portfolio-summary',
      body: { eventType: 'event_type-value' }
    )
    service.get_prediction_portfolio_summary(event_type: 'event_type-value')
  end

  # endpoint: POST /v5/alpha/prediction/position-history
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/position-history',
      body: { limit: 1, pageIndex: 1, direction: 'prev' }
    )
    service.get_prediction_position_history(limit: 1, page_index: 1, direction: 'prev')
  end

  # endpoint: POST /v5/alpha/prediction/position-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/position-list',
      body: { limit: 1, pageIndex: 1, direction: 'prev' }
    )
    service.get_prediction_position_list(limit: 1, page_index: 1, direction: 'prev')
  end

  # endpoint: POST /v5/alpha/prediction/price-history
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/price-history',
      body: {
        tokenId: 'token_id-value',
        interval: 'interval-value'
      }
    )
    service.get_prediction_price_history(
      token_id: 'token_id-value',
      interval: 'interval-value'
    )
  end

  # endpoint: POST /v5/alpha/prediction/sell
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/sell',
      body: {
        tokenId: 'token_id-value',
        size: 'size-value',
        orderType: 'order_type-value',
        slippage: 'slippage-value',
        eventId: 'event_id-value',
        toTokenCode: 'to_token_code-value'
      }
    )
    service.execute_prediction_sell(
      token_id: 'token_id-value',
      size: 'size-value',
      order_type: 'order_type-value',
      slippage: 'slippage-value',
      event_id: 'event_id-value',
      to_token_code: 'to_token_code-value'
    )
  end

  # endpoint: POST /v5/alpha/prediction/side-market-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/side-market-list',
      body: { eventId: 'event_id-value' }
    )
    service.get_prediction_side_market_list(event_id: 'event_id-value')
  end

  # endpoint: POST /v5/alpha/prediction/sports/group-stage-detail
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/sports/group-stage-detail',
      body: { eventType: 'event_type-value', groupName: 'group_name-value' }
    )
    service.get_prediction_group_stage_detail(
      event_type: 'event_type-value',
      group_name: 'group_name-value'
    )
  end

  # endpoint: POST /v5/alpha/prediction/sports/match-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/sports/match-list',
      body: {
        eventType: 'event_type-value',
        status: 1,
        startTime: 1,
        endTime: 1,
        stageCode: 'stage_code-value',
        limit: 1,
        pageIndex: 1
      }
    )
    service.get_prediction_match_list(
      event_type: 'event_type-value',
      status: 1,
      start_time: 1,
      end_time: 1,
      stage_code: 'stage_code-value',
      limit: 1,
      page_index: 1
    )
  end

  # endpoint: POST /v5/alpha/prediction/token-price
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/prediction/token-price',
      body: { tokenIds: ['token_ids-value'] }
    )
    service.get_prediction_token_price(token_ids: ['token_ids-value'])
  end

  # endpoint: POST /v5/alpha/trade/asset-detail
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/asset-detail',
      body: { chainCode: 'chain_code-value', tokenAddress: 'token_address-value' }
    )
    service.get_asset_detail(chain_code: 'chain_code-value', token_address: 'token_address-value')
  end

  # endpoint: POST /v5/alpha/trade/asset-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/asset-list'
    )
    service.get_asset_list
  end

  # endpoint: POST /v5/alpha/trade/biz-token-details
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/biz-token-details',
      body: { chainCode: 'chain_code-value', tokenAddress: 'token_address-value' }
    )
    service.get_biz_token_details(
      chain_code: 'chain_code-value',
      token_address: 'token_address-value'
    )
  end

  # endpoint: POST /v5/alpha/trade/biz-token-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/biz-token-list',
      body: { tokenTag: 0 }
    )
    service.get_biz_token_list(token_tag: 0)
  end

  # endpoint: POST /v5/alpha/trade/biz-token-price-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/biz-token-price-list',
      body: { tokenAddressInfo: ['token_address_info-value'] }
    )
    service.get_biz_token_price_list(token_address_info: ['token_address_info-value'])
  end

  # endpoint: POST /v5/alpha/trade/order-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/order-list',
      body: {
        tradeType: 0,
        tokenCode: 'token_code-value',
        orderStatus: ['order_status-value'],
        days: 1,
        limit: 1,
        pageIndex: 1,
        direction: 'prev'
      }
    )
    service.get_order_list(
      trade_type: 0,
      token_code: 'token_code-value',
      order_status: ['order_status-value'],
      days: 1,
      limit: 1,
      page_index: 1,
      direction: 'prev'
    )
  end

  # endpoint: POST /v5/alpha/trade/pay-token-list
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/pay-token-list',
      body: { chainCode: 'chain_code-value', tokenAddress: 'token_address-value' }
    )
    service.get_pay_token_list(chain_code: 'chain_code-value', token_address: 'token_address-value')
  end

  # endpoint: POST /v5/alpha/trade/purchase
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/purchase',
      body: {
        fromTokenCode: 'from_token_code-value',
        fromTokenAmount: 'from_token_amount-value',
        toTokenCode: 'to_token_code-value',
        slippage: 'slippage-value',
        quoteData: 'quote_data-value',
        gas: 'gas-value',
        quoteMode: 0,
        correctingCode: 'correcting_code-value',
        tenant: 'tenant-value'
      }
    )
    service.execute_purchase(
      from_token_code: 'from_token_code-value',
      from_token_amount: 'from_token_amount-value',
      to_token_code: 'to_token_code-value',
      slippage: 'slippage-value',
      quote_data: 'quote_data-value',
      gas: 'gas-value',
      quote_mode: 0,
      correcting_code: 'correcting_code-value',
      tenant: 'tenant-value'
    )
  end

  # endpoint: POST /v5/alpha/trade/quote
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/quote',
      body: {
        tradeType: 1,
        fromTokenCode: 'from_token_code-value',
        fromTokenAmount: 'from_token_amount-value',
        toTokenCode: 'to_token_code-value',
        quoteMode: 0
      }
    )
    service.get_trade_quote(
      trade_type: 1,
      from_token_code: 'from_token_code-value',
      from_token_amount: 'from_token_amount-value',
      to_token_code: 'to_token_code-value',
      quote_mode: 0
    )
  end

  # endpoint: POST /v5/alpha/trade/redeem
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::AlphaService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/alpha/trade/redeem',
      body: {
        fromTokenCode: 'from_token_code-value',
        fromTokenAmount: 'from_token_amount-value',
        toTokenCode: 'to_token_code-value',
        slippage: 'slippage-value',
        quoteData: 'quote_data-value',
        gas: 'gas-value',
        quoteMode: 0,
        correctingCode: 'correcting_code-value',
        tenant: 'tenant-value'
      }
    )
    service.execute_redeem(
      from_token_code: 'from_token_code-value',
      from_token_amount: 'from_token_amount-value',
      to_token_code: 'to_token_code-value',
      slippage: 'slippage-value',
      quote_data: 'quote_data-value',
      gas: 'gas-value',
      quote_mode: 0,
      correcting_code: 'correcting_code-value',
      tenant: 'tenant-value'
    )
  end

  # endpoint: POST /v5/fht/compliance/tax/private/batch_create
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::TaxService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/fht/compliance/tax/private/batch_create',
      body: {
        startTime: 1,
        endTime: 1,
        items: ['items-value'],
        sourceInstitution: 'source_institution-value',
        exportFileType: 'csv'
      }
    )
    service.batch_create_tax_reports(
      start_time: 1,
      end_time: 1,
      items: ['items-value'],
      source_institution: 'source_institution-value',
      export_file_type: 'csv'
    )
  end

  # endpoint: POST /v5/fiat/quote-apply
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/fiat/quote-apply',
      body: {
        fromCoin: 'from_coin-value',
        fromCoinType: 'fiat',
        toCoin: 'to_coin-value',
        toCoinType: 'fiat',
        requestAmount: 'request_amount-value',
        requestCoinType: 'fiat'
      }
    )
    service.apply_quote(
      from_coin: 'from_coin-value',
      from_coin_type: 'fiat',
      to_coin: 'to_coin-value',
      to_coin_type: 'fiat',
      request_amount: 'request_amount-value',
      request_coin_type: 'fiat'
    )
  end

  # endpoint: POST /v5/fiat/trade-execute
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::FiatService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/fiat/trade-execute',
      body: {
        quoteTxId: 'quote_tx_id-value',
        subUserId: 'sub_user_id-value',
        webhookUrl: 'webhook_url-value',
        merchantRequestId: 'merchant_request_id-value'
      }
    )
    service.confirm_quote(
      quote_tx_id: 'quote_tx_id-value',
      sub_user_id: 'sub_user_id-value',
      webhook_url: 'webhook_url-value',
      merchant_request_id: 'merchant_request_id-value'
    )
  end

  # endpoint: POST /v5/referral/campaign/rewards
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::ReferralService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/referral/campaign/rewards'
    )
    service.get_campaign_rewards
  end

  # endpoint: POST /v5/referral/commission/records
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::ReferralService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/referral/commission/records',
      body: {
        userIdList: ['user_id_list-value'],
        startTime: 'start_time-value',
        endTime: 'end_time-value',
        page: 1,
        pageSize: 1,
        productLine: 0
      }
    )
    service.get_commission_records(
      user_id_list: ['user_id_list-value'],
      start_time: 'start_time-value',
      end_time: 'end_time-value',
      page: 1,
      page_size: 1,
      product_line: 0
    )
  end

  # endpoint: POST /v5/referral/user/identity-profile
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::ReferralService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/referral/user/identity-profile'
    )
    service.get_user_identity_profile
  end

  # endpoint: POST /v5/referral/user/invitations
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::ReferralService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/referral/user/invitations',
      body: {
        userIdList: ['user_id_list-value'],
        startTime: 'start_time-value',
        endTime: 'end_time-value',
        page: 1,
        pageSize: 1,
        friendStatus: 0
      }
    )
    service.get_user_invitations(
      user_id_list: ['user_id_list-value'],
      start_time: 'start_time-value',
      end_time: 'end_time-value',
      page: 1,
      page_size: 1,
      friend_status: 0
    )
  end

  # endpoint: POST /v5/spot-margin-trade/fixedborrow-order-cancel
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotMarginService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spot-margin-trade/fixedborrow-order-cancel',
      body: { orderId: 'order_id-value' }
    )
    service.cancel_fixed_borrow_order(order_id: 'order_id-value')
  end

  # endpoint: POST /v5/spot-x/launchpool/user/activity-log
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spot-x/launchpool/user/activity-log',
      body: {
        stakeCoin: 'stake_coin-value',
        type: 1,
        status: 1,
        startTime: 'start_time-value',
        endTime: 'end_time-value',
        pageSize: 1,
        current: 1
      }
    )
    service.get_launchpool_user_activity_log(
      stake_coin: 'stake_coin-value',
      type: 1,
      status: 1,
      start_time: 'start_time-value',
      end_time: 'end_time-value',
      page_size: 1,
      current: 1
    )
  end

  # endpoint: POST /v5/spot-x/launchpool/user/history
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpotXService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spot-x/launchpool/user/history',
      body: {
        stakeCoin: 'stake_coin-value',
        rewardCoin: 'reward_coin-value',
        startTime: 'start_time-value',
        endTime: 'end_time-value',
        pageSize: 1,
        current: 1
      }
    )
    service.get_launchpool_user_history(
      stake_coin: 'stake_coin-value',
      reward_coin: 'reward_coin-value',
      start_time: 'start_time-value',
      end_time: 'end_time-value',
      page_size: 1,
      current: 1
    )
  end

  # endpoint: POST /v5/spread/order/amend
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spread/order/amend',
      body: {
        symbol: 'symbol-value',
        orderId: 'order_id-value',
        orderLinkId: 'order_link_id-value',
        qty: 'qty-value',
        price: 'price-value'
      }
    )
    service.amend_spread_order(
      symbol: 'symbol-value',
      order_id: 'order_id-value',
      order_link_id: 'order_link_id-value',
      qty: 'qty-value',
      price: 'price-value'
    )
  end

  # endpoint: POST /v5/spread/order/cancel
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spread/order/cancel',
      body: { orderId: 'order_id-value', orderLinkId: 'order_link_id-value' }
    )
    service.cancel_spread_order(order_id: 'order_id-value', order_link_id: 'order_link_id-value')
  end

  # endpoint: POST /v5/spread/order/cancel-all
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spread/order/cancel-all',
      body: { symbol: 'symbol-value', cancelAll: true }
    )
    service.cancel_all_spread_orders(symbol: 'symbol-value', cancel_all: true)
  end

  # endpoint: POST /v5/spread/order/create
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::SpreadTradeService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/spread/order/create',
      body: {
        symbol: 'symbol-value',
        side: 'Buy',
        orderType: 'Limit',
        qty: 'qty-value',
        price: 'price-value',
        orderLinkId: 'order_link_id-value',
        timeInForce: 'GTC'
      }
    )
    service.create_spread_order(
      symbol: 'symbol-value',
      side: 'Buy',
      order_type: 'Limit',
      qty: 'qty-value',
      price: 'price-value',
      order_link_id: 'order_link_id-value',
      time_in_force: 'GTC'
    )
  end

  # endpoint: POST /v5/strategy/create
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::StrategyService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/strategy/create',
      body: { strategyType: 'chaseOrder', nestedOption: { innerKey: 'inner-value' } }
    )
    service.create_strategy(
      strategy_type: 'chaseOrder',
      nested_option: { inner_key: 'inner-value' }
    )
  end

  # endpoint: POST /v5/strategy/stop
  it 'dispatches this generated endpoint' do
    session = instance_double(Bybit::Session)
    service = Bybit::RestApi::StrategyService.new(session)
    expect(session).to receive(:sign_request).with(
      method: :post,
      path: '/v5/strategy/stop',
      body: { strategyId: 'strategy_id-value' }
    )
    service.stop_strategy(strategy_id: 'strategy_id-value')
  end
  # gen-sdk-ruby:generated-service-specs:end
end
