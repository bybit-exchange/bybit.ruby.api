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
        # WebMock title-cases header keys (`X-Bapi-Api-Key`), so match case-insensitively.
        seen = req.headers.keys.map(&:downcase)
        %w[X-BAPI-API-KEY X-BAPI-TIMESTAMP X-BAPI-RECV-WINDOW X-BAPI-SIGN X-BAPI-SIGN-TYPE]
          .all? { |h| seen.include?(h.downcase) }
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

    # README promises 401/403 → AuthError, 429 → RateLimitError. These are
    # transport-layer statuses returned by CDN/WAF with no Bybit body — the
    # generic ClientError bucket would silently miss the rescue clauses
    # documented in README.md#Error-Handling.
    it 'raises AuthError on HTTP 401 with non-JSON body' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_return(
        status: 401, body: 'Unauthorized',
      )
      expect { session.public_request(path: '/v5/market/time') }
        .to raise_error(Bybit::AuthError) { |e| expect(e.http_status).to eq(401) }
    end

    it 'raises AuthError on HTTP 403 with non-JSON body' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_return(
        status: 403, body: 'Forbidden',
      )
      expect { session.public_request(path: '/v5/market/time') }
        .to raise_error(Bybit::AuthError) { |e| expect(e.http_status).to eq(403) }
    end

    it 'raises RateLimitError on HTTP 429 with non-JSON body' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_return(
        status: 429, body: 'Too Many Requests',
      )
      expect { session.public_request(path: '/v5/market/time') }
        .to raise_error(Bybit::RateLimitError) { |e| expect(e.http_status).to eq(429) }
    end

    it 'maps Faraday::TimeoutError to Bybit::TimeoutError' do
      stub_request(:get, %r{https://api-testnet\.bybit\.com/v5/market/time}).to_timeout
      expect { session.public_request(path: '/v5/market/time') }.to raise_error(Bybit::TimeoutError)
    end

    # P2P endpoints return the pre-V5 envelope {ret_code, ret_msg, ext_info,
    # time_now}. Without aliasing, a valid P2P error response is misclassified
    # as ParseError — swallows the retCode and prevents AuthError / RateLimit
    # mapping. Regression guard for that.
    it 'aliases legacy ret_code/ret_msg envelope (P2P) into V5 shape' do
      stub_request(:post, 'https://api-testnet.bybit.com/v5/p2p/user/personal/info').to_return(
        status: 200,
        body: '{"ret_code":10003,"ret_msg":"API key is invalid.","result":{},"ext_code":"","ext_info":null,"time_now":"1700000000.123456"}',
        headers: { 'Content-Type' => 'application/json' }
      )
      expect { session.sign_request(method: :post, path: '/v5/p2p/user/personal/info', body: {}) }
        .to raise_error(Bybit::AuthError, /10003/)
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
