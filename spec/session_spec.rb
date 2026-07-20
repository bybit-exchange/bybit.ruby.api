# frozen_string_literal: true

# Session-level regressions: signature payload branch by HTTP verb, header
# presence, error-class mapping.
RSpec.describe Bybit::Session do
  let(:config) do
    c = Bybit::Configuration.new
    c.api_key    = 'test-key'
    c.api_secret = 'test-secret'
    c.base_url   = 'https://api-testnet.bybit.com'
    c.recv_window = '5000'
    c
  end
  let(:session) { described_class.new(config) }

  describe 'signed dispatch' do
    it 'signs GET query-string exactly as it appears on the wire' do
      url = %r{https://api-testnet\.bybit\.com/v5/account/wallet-balance}
      stub_request(:get, url).to_return(
        status: 200, body: '{"retCode":0,"retMsg":"OK","result":{},"retExtInfo":{},"time":0}',
        headers: { 'Content-Type' => 'application/json' }
      )
      session.sign_request(method: :get, path: '/v5/account/wallet-balance', params: { accountType: 'UNIFIED' })
      expect(WebMock).to(have_requested(:get, url).with do |req|
        %w[X-BAPI-API-KEY X-BAPI-TIMESTAMP X-BAPI-RECV-WINDOW X-BAPI-SIGN X-BAPI-SIGN-TYPE]
          .all? { |h| req.headers.key?(h) }
      end)
    end

    it 'signs POST body-string, does NOT send params on query string' do
      stub = stub_request(:post, 'https://api-testnet.bybit.com/v5/order/create').to_return(
        status: 200, body: '{"retCode":0,"retMsg":"OK","result":{},"retExtInfo":{},"time":0}',
        headers: { 'Content-Type' => 'application/json' },
      )
      session.sign_request(method: :post, path: '/v5/order/create', body: { category: 'linear', symbol: 'BTCUSDT' })
      expect(stub).to have_been_requested
    end

    it 'signs DELETE-with-params using the query string (not empty body)' do
      stub = stub_request(:delete, %r{https://api-testnet\.bybit\.com/v5/order/cancel\?}).to_return(
        status: 200, body: '{"retCode":0,"retMsg":"OK","result":{},"retExtInfo":{},"time":0}',
        headers: { 'Content-Type' => 'application/json' },
      )
      session.sign_request(method: :delete, path: '/v5/order/cancel', params: { orderId: 'abc123' })
      expect(stub).to have_been_requested
    end

    it 'raises ConfigurationError when api_key is missing' do
      config.api_key = nil
      expect { session.sign_request(method: :get, path: '/v5/account/wallet-balance') }
        .to raise_error(Bybit::ConfigurationError, /api_key/)
    end
  end

  describe 'error mapping' do
    it 'raises AuthError on retCode 10004' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/account/wallet-balance}).to_return(
        status: 200, body: '{"retCode":10004,"retMsg":"error sign","result":{},"retExtInfo":{},"time":0}',
        headers: { 'Content-Type' => 'application/json' },
      )
      expect { session.sign_request(method: :get, path: '/v5/account/wallet-balance') }
        .to raise_error(Bybit::AuthError)
    end

    it 'raises RateLimitError on retCode 10006' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/account/wallet-balance}).to_return(
        status: 200, body: '{"retCode":10006,"retMsg":"too many","result":{},"retExtInfo":{},"time":0}',
        headers: { 'Content-Type' => 'application/json' },
      )
      expect { session.sign_request(method: :get, path: '/v5/account/wallet-balance') }
        .to raise_error(Bybit::RateLimitError)
    end

    it 'raises ServerError on 5xx with non-JSON body' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_return(
        status: 502, body: '<html>Bad Gateway</html>',
      )
      expect { session.public_request(path: '/v5/market/time') }.to raise_error(Bybit::ServerError)
    end

    it 'raises ClientError on non-auth 4xx with non-JSON body' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_return(
        status: 400, body: 'bad request',
      )
      expect { session.public_request(path: '/v5/market/time') }.to raise_error(Bybit::ClientError)
    end

    it 'maps Faraday::TimeoutError to Bybit::TimeoutError' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_timeout
      expect { session.public_request(path: '/v5/market/time') }.to raise_error(Bybit::TimeoutError)
    end
  end

  describe 'POST + params guard' do
    it 'raises ConfigurationError when caller mixes body: + params: on POST' do
      expect {
        session.sign_request(method: :post, path: '/v5/order/create', params: { a: 1 }, body: { b: 2 })
      }.to raise_error(Bybit::ConfigurationError, /params:/)
    end
  end
end
