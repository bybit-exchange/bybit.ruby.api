# frozen_string_literal: true

require 'support/vcr_setup'

# End-to-end integration coverage using VCR cassettes. Two things this file
# guarantees that the WebMock-based service specs don't:
#
# 1. The full request that leaves the SDK — verb, URL, query string, JSON
#    body — matches the recorded cassette byte-for-byte. Any drift in
#    WireKeys camelization, query encoding, or POST body serialization
#    causes VCR to raise UnhandledHTTPRequestError.
# 2. The HMAC signature that ships in the X-BAPI-SIGN header is exactly the
#    value derived from the signed payload. Signatures are checked in-spec
#    against a pre-computed golden value (Time is frozen so signing is
#    deterministic).
RSpec.describe 'REST end-to-end via VCR', :vcr do
  let(:config) do
    c = Bybit::Configuration.new
    c.api_key    = 'test-key'
    c.api_secret = 'test-secret'
    c.testnet    = true
    c.recv_window = '5000'
    c
  end
  let(:client)  { Bybit::Client.new(config) }
  # Freeze the signing timestamp so the recorded signature stays stable.
  let(:fixed_ms) { 1_700_000_000_000 }

  before do
    allow(Time).to receive(:now).and_return(Time.at(fixed_ms / 1000.0))
  end

  it 'issues an unsigned public GET (market/time) and parses the V5 envelope' do
    VCR.use_cassette('market_get_server_time') do
      resp = client.market.get_server_time
      expect(resp['retCode']).to eq(0)
      expect(resp['result']['timeSecond']).to eq('1700000000')
    end
  end

  it 'signs a GET params-in-query (account/wallet-balance) with the expected HMAC header' do
    VCR.use_cassette('account_get_wallet_balance') do
      captured = nil
      WebMock.after_request do |req, _|
        captured = req if req.uri.path == '/v5/account/wallet-balance'
      end

      resp = client.account.get_wallet_balance(account_type: 'UNIFIED')
      expect(resp['retCode']).to eq(0)

      # HMAC over: timestamp + api_key + recv_window + query_string.
      # Golden value is precomputed in tools/gen_signatures — DO NOT
      # regenerate without also updating the cassette request URL.
      expected_sig = '3f10586267639c9f3f4f5e32e491a6ef80d157db06f51eb79e4988e24f97adba'
      expect(captured.headers['X-Bapi-Sign']).to eq(expected_sig)
      expect(captured.headers['X-Bapi-Timestamp']).to eq(fixed_ms.to_s)
      expect(captured.headers['X-Bapi-Api-Key']).to eq('test-key')
      # params: routes to the query string, NEVER the body, on GET.
      expect(captured.uri.query).to eq('accountType=UNIFIED')
      expect(captured.body.to_s).to eq('')
    end
  end

  it 'signs a POST body-only (order/create) — body: routes to JSON, no query string' do
    VCR.use_cassette('trade_create_order') do
      captured = nil
      WebMock.after_request do |req, _|
        captured = req if req.uri.path == '/v5/order/create'
      end

      resp = client.trade.create_order(
        category: 'linear', symbol: 'BTCUSDT', side: 'Buy',
        order_type: 'Limit', qty: '0.01', price: '30000', time_in_force: 'GTC'
      )
      expect(resp['result']['orderId']).to eq('1234567890')

      # HMAC over the JSON body string (POST branch of the signer). Golden
      # value pinned to the exact insertion order of `kwargs.merge(...)` in
      # TradeService#create_order — if that method reorders its merges, this
      # signature drifts and the test fails, protecting the wire contract.
      expected_sig = 'aae80c0b052347759ce532cce2f73dac47a96738d646e3df3969bcd733a9af8e'
      expect(captured.headers['X-Bapi-Sign']).to eq(expected_sig)
      # Body-carrying POST does NOT populate the query string.
      expect(captured.uri.query).to be_nil
      # Wire body follows kwargs-first insertion order (see comment above).
      expect(captured.body).to eq(
        '{"price":"30000","timeInForce":"GTC","category":"linear",' \
        '"symbol":"BTCUSDT","side":"Buy","orderType":"Limit","qty":"0.01"}'
      )
    end
  end
end
