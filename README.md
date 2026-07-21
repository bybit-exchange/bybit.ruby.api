# bybit-connector-ruby

Official lightweight Ruby connector for the [Bybit V5 REST API](https://bybit-exchange.github.io/docs/v5/intro).

`bybit-connector-ruby` wraps the Bybit V5 HTTP endpoints as a set of typed Ruby methods with keyword-arg signatures. Its goal is the same as [`pybit`](https://github.com/bybit-exchange/pybit) on the Python side: an easy-to-use, high-performance connector with a small dependency footprint.

## Installation

Ruby ≥ 3.0 is required (Ruby 3.3.x recommended).

```
gem install bybit-connector-ruby
```

Or in your Gemfile:

```ruby
gem 'bybit-connector-ruby'
```

## Quick Start

```ruby
require 'bybit'

Bybit.configure do |c|
  c.api_key    = ENV['BYBIT_KEY']
  c.api_secret = ENV['BYBIT_SECRET']
  c.testnet    = true      # omit / false for mainnet
end

client = Bybit::Client.new

# Public endpoint — no auth needed
puts client.market.get_server_time

# Signed endpoint — apiKey + apiSecret required
wallet = client.account.get_wallet_balance(account_type: 'UNIFIED')
puts wallet['result']['list']

# Place an order
order = client.trade.create_order(
  category: 'linear', symbol: 'BTCUSDT',
  side: 'Buy', order_type: 'Limit', qty: '0.01',
  price: '30000', time_in_force: 'GTC',
)
puts "orderId: #{order['result']['orderId']}"
```

See `examples/quickstart.rb` for a runnable script.

## Configuration

All options live on `Bybit::Configuration`. Either configure globally with the block:

```ruby
Bybit.configure do |c|
  c.api_key    = ENV['BYBIT_KEY']
  c.api_secret = ENV['BYBIT_SECRET']
  c.testnet    = false             # default false
  c.recv_window = '5000'           # ms, X-BAPI-RECV-WINDOW header
  c.timeout    = 10                # Faraday timeout, seconds
end
```

Or pass overrides to `Client.new`:

```ruby
client = Bybit::Client.new(api_key: '...', api_secret: '...', testnet: true)
```

Bring your own Faraday connection to inject retries / logging / adapters:

```ruby
conn = Faraday.new('https://api-testnet.bybit.com') do |f|
  f.request :retry, max: 3
  f.response :logger
end
Bybit.configure { |c| c.faraday_connection = conn }
```

Base URLs (exported constants):

- `Bybit::BASE_URL_MAINNET` — `https://api.bybit.com`
- `Bybit::BASE_URL_TESTNET` — `https://api-testnet.bybit.com`

## Services

Each API group is a property on `Bybit::Client`:

- `client.market` — public market data (kline, tickers, orderbook, instruments-info, ...)
- `client.trade` — orders (create / amend / cancel / batch / history)
- `client.position` — positions, leverage, TP/SL, move-position
- `client.account` — wallet, margin, collateral, fee-rate, transaction log
- `client.asset` — coin balance, coin greeks, funding history
- `client.user` — sub-accounts, API-key management
- `client.affiliate` — sub-affiliate lists
- `client.broker` — broker earnings, distributions
- `client.crypto_loan` — flexible / fixed crypto loans
- `client.institutional_loan` — /v5/ins-loan/* (OTC institutional loans)
- `client.rfq` — request-for-quote (block trades)
- `client.spot_margin` — UTA spot margin
- `client.earn` — earn, liquidity mining, RWA, PWM, hold-to-earn
- `client.p2p` — P2P advertise / order / chat
- `client.bot` — DCA / grid / futures-combo / futures-grid / martingale
- `client.pre_upgrade` — /v5/pre-upgrade/* historical queries for Classic → UTA upgrades
- `client.misc` — /v5/announcements/index, /v5/system/status

## Error Handling

Every failure is a subclass of `Bybit::Error`:

```ruby
begin
  client.trade.create_order(category: 'linear', symbol: 'BTCUSDT', side: 'Buy', ...)
rescue Bybit::AuthError => e         # retCode 10003/10004/10005/... or HTTP 401/403
  # bad key / bad sign / permission
rescue Bybit::RateLimitError => e    # retCode 10006 / 10018 or HTTP 429
  sleep 1 && retry
rescue Bybit::TimeoutError => e      # Faraday::TimeoutError
rescue Bybit::NetworkError => e      # Faraday::ConnectionFailed / SSLError
rescue Bybit::ServerError => e       # HTTP 5xx w/ non-JSON body
rescue Bybit::ClientError => e       # HTTP 4xx w/ non-JSON body (WAF, CDN, etc.)
rescue Bybit::ParseError => e        # unrecognized body shape; e.body holds raw payload
rescue Bybit::ApiError => e          # any other retCode != 0 — catch-all API error
end
```

Full hierarchy:

- `Bybit::Error` (StandardError)
  - `Bybit::ConfigurationError` — missing api_key / conflicting options
  - `Bybit::TransportError`
    - `Bybit::TimeoutError`
    - `Bybit::NetworkError`
    - `Bybit::ServerError` (5xx w/o body)
    - `Bybit::ClientError` (non-auth 4xx w/o body)
    - `Bybit::ParseError` — body did not parse or shape mismatch (has `#body`, `#http_status`)
  - `Bybit::ApiError` — Bybit V5 body with retCode != 0
    - `Bybit::AuthError`
    - `Bybit::RateLimitError`

Every `ApiError` exposes `#ret_code`, `#ret_msg`, `#result`, `#time`, `#http_status`. See the [Bybit V5 error-code list](https://bybit-exchange.github.io/docs/v5/error) for meanings.

## Return Value

Every service method returns the raw parsed JSON as a `Hash`:

```ruby
response = client.market.get_kline(category: 'spot', symbol: 'BTCUSDT', interval: '1')
response['retCode']    # => 0
response['retMsg']     # => 'OK'
response['result']     # => { 'category' => 'spot', 'symbol' => 'BTCUSDT', 'list' => [...] }
response['time']       # => 1234567890000
```

## Testnet

Flip `testnet: true` for [https://testnet.bybit.com](https://testnet.bybit.com):

```ruby
client = Bybit::Client.new(
  api_key:    ENV['BYBIT_TESTNET_KEY'],
  api_secret: ENV['BYBIT_TESTNET_SECRET'],
  testnet:    true,
)
```

REST base URLs (exported constants):

- `Bybit::BASE_URL_MAINNET` — `https://api.bybit.com`
- `Bybit::BASE_URL_TESTNET` — `https://api-testnet.bybit.com`

WebSocket hosts follow the same split:

- Mainnet — `wss://stream.bybit.com/v5/{public/<category>|private|trade}`
- Testnet — `wss://stream-testnet.bybit.com/v5/{public/<category>|private|trade}`

## WebSockets

WebSocket support ships behind an opt-in require so REST-only consumers don't
load the underlying `websocket-client-simple` dependency at boot:

```ruby
require 'bybit/websocket'

# Public stream — no auth needed.
public_ws = Bybit::WebSocket::Client.new(
  channel: :linear,           # :spot / :linear / :inverse / :option
  testnet: false,
  on_message: ->(msg) { puts msg.inspect },
).connect

public_ws.subscribe('tickers.BTCUSDT', 'orderbook.1.BTCUSDT')

# Private stream — HMAC-SHA256 auth over "GET/realtime" + expiry.
private_ws = Bybit::WebSocket::Client.new(
  channel:    :private,
  api_key:    ENV['BYBIT_KEY'],
  api_secret: ENV['BYBIT_SECRET'],
  on_message: ->(msg) { handle_private_event(msg) },
).connect

private_ws.subscribe('position', 'order', 'wallet')

# Later:
private_ws.unsubscribe('wallet')
private_ws.disconnect
```

Supported channels: `:spot`, `:linear`, `:inverse`, `:option`, `:private`,
`:trade`. `testnet: true` swaps in the `stream-testnet.bybit.com` host.
Pings ship every 20 seconds — Bybit closes idle sockets after ~20s of
silence. There is no automatic reconnect on network drop: callers listening
on `on_close` can invoke `#connect` again to reopen the socket and replay
the buffered `#subscriptions`.

## Development

```
bundle install
bundle exec rspec       # tests
bundle exec rubocop     # lint
bundle exec rake        # both
```

## License

MIT — see [LICENSE](LICENSE).
