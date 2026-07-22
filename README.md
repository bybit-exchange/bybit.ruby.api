# bybit-connector-ruby

Official lightweight Ruby connector for the [Bybit V5 REST API](https://bybit-exchange.github.io/docs/v5/intro).

`bybit-connector-ruby` wraps the Bybit V5 HTTP endpoints as a set of typed Ruby methods with keyword-arg signatures. 
## Prerequisites

Before you write any code you need a Bybit API key. Two accounts to know
about:

- **Testnet** — [testnet.bybit.com](https://testnet.bybit.com) → sign up →
  API Management → *Create New Key*. This is where you should point every
  new integration until you're confident about behavior. Testnet balances
  are virtual; nothing you do here touches real funds.
- **Mainnet** — [bybit.com](https://www.bybit.com) → API Management. Real
  money. Enable only the permissions you actually need (spot / derivatives /
  withdrawals) and prefer IP-restricted keys.

Testnet and mainnet keys are **separate** — an API key issued on one won't
work against the other. The SDK selects the environment via
`testnet: true|false` (or an explicit `base_url:` override).

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

# All calls below run against testnet — swap testnet: false for mainnet
# once you're happy with the behavior.
Bybit.configure do |c|
  c.api_key    = ENV['BYBIT_TESTNET_KEY']
  c.api_secret = ENV['BYBIT_TESTNET_SECRET']
  c.testnet    = true
end

client = Bybit::Client.new

# 1. Public endpoint — no auth needed.
puts client.market.get_server_time

# 2. Signed endpoint — api_key + api_secret required.
wallet = client.account.get_wallet_balance(account_type: 'UNIFIED')
puts wallet['result']['list']

# 3. Place a LIMIT order well below market so it sits on the book and does
#    NOT fill (safe to run repeatedly). Adjust `price:` if BTC ever trades
#    at $10k again — otherwise this stays a resting order you can cancel.
order = client.trade.create_order(
  category: 'linear', symbol: 'BTCUSDT',
  side: 'Buy', order_type: 'Limit', qty: '0.01',
  price: '10000', time_in_force: 'GTC'
)
order_id = order['result']['orderId']
puts "orderId: #{order_id}"

# 4. Cancel it before moving on.
client.trade.cancel_order(category: 'linear', symbol: 'BTCUSDT', order_id: order_id)
```

> ⚠️ **Before switching `testnet: false`**: verify the price / qty in
> `create_order` won't cross the top of the book — a Limit Buy at $10k on
> mainnet becomes a market fill instantly (if BTC ever drops that low),
> and a Limit Sell at $1M does the reverse.

See `examples/quickstart.rb` for a runnable script.

## Configuration

All options live on `Bybit::Configuration`. Either configure globally with the block:

```ruby
Bybit.configure do |c|
  c.api_key    = ENV['BYBIT_KEY']
  c.api_secret = ENV['BYBIT_SECRET']
  c.testnet    = false             # default false
  c.recv_window = '5000'           # milliseconds — Bybit rejects requests
                                   # whose signed timestamp is older than
                                   # this window. Bump to 10000+ if your
                                   # clock drifts or the network is noisy.
  c.timeout    = 10                # Faraday timeout, seconds
end
```

Or pass overrides to `Client.new` — **per-client overrides win over
`Bybit.configure`**, so you can share defaults globally and still spin up a
dedicated client with a different key or environment:

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

> The `sleep 1 && retry` shown above is fine for exploration, **not** for
> production — Bybit will escalate throttling on tight retry loops. For
> real workloads, wire a `Faraday::Retry` middleware with exponential
> backoff via the "bring your own Faraday connection" hook in
> [Configuration](#configuration) above.

## Return Value

Every service method returns the raw parsed JSON as a `Hash`:

```ruby
response = client.market.get_kline(category: 'spot', symbol: 'BTCUSDT', interval: '1')
response['retCode']    # => 0
response['retMsg']     # => 'OK'
response['result']     # => { 'category' => 'spot', 'symbol' => 'BTCUSDT', 'list' => [...] }
response['time']       # => 1234567890000
```

> Keys are **strings, not symbols** — `response[:result]` is `nil`. This is
> a common first-hour gotcha; pass through `JSON.parse` semantics rather
> than converting.

## Method Reference

Method names follow the Bybit V5 endpoint slug in snake_case, grouped by
domain. A few illustrative mappings:

| Bybit V5 path                         | SDK method                                |
| ------------------------------------- | ----------------------------------------- |
| `GET  /v5/market/kline`               | `client.market.get_kline`                 |
| `GET  /v5/market/tickers`             | `client.market.get_tickers`               |
| `POST /v5/order/create`               | `client.trade.create_order`               |
| `POST /v5/order/cancel`               | `client.trade.cancel_order`               |
| `GET  /v5/position/list`              | `client.position.get_positions`           |
| `GET  /v5/account/wallet-balance`     | `client.account.get_wallet_balance`       |

For the full list, generate YARD docs locally:

```
bundle exec yard doc
open doc/index.html
```

or browse the published copy on
[rubydoc.info/gems/bybit-connector-ruby](https://rubydoc.info/gems/bybit-connector-ruby).

## Pagination

Bybit V5 uses **opaque cursor pagination** — the response's
`result['nextPageCursor']` (empty string when the page is the last one)
feeds back in as the `cursor:` argument on the next call:

```ruby
cursor = nil
loop do
  resp = client.trade.get_order_history(category: 'linear', limit: 50, cursor: cursor)
  resp['result']['list'].each { |order| process(order) }
  cursor = resp['result']['nextPageCursor']
  break if cursor.nil? || cursor.empty?
end
```

The same pattern works for `get_positions`, `get_execution_history`,
`get_transaction_log`, and every other paginated endpoint.

## WebSockets

Hosts (mirror the REST split):

- Mainnet — `wss://stream.bybit.com/v5/{public/<category>|private|trade}`
- Testnet — `wss://stream-testnet.bybit.com/v5/{public/<category>|private|trade}`

WebSocket support ships behind an opt-in require so REST-only consumers don't
load the underlying `websocket-client-simple` dependency at boot. Four
callbacks are available; all are optional but you'll almost always want at
least `on_message`.

```ruby
require 'bybit/websocket'

# Public stream — no auth needed.
public_ws = Bybit::WebSocket::Client.new(
  channel: :linear,           # :spot / :linear / :inverse / :option
  testnet: true,
  on_open:    -> { puts 'connected' },
  on_message: ->(msg) { puts msg.inspect },              # your handler
  on_close:   ->(_ev) { puts 'closed'  },
  on_error:   ->(err) { warn "ws error: #{err}" }
).connect

public_ws.subscribe('tickers.BTCUSDT', 'orderbook.1.BTCUSDT')

# Private stream — HMAC-SHA256 auth over "GET/realtime" + expiry.
private_ws = Bybit::WebSocket::Client.new(
  channel:    :private,
  testnet:    true,
  api_key:    ENV['BYBIT_TESTNET_KEY'],
  api_secret: ENV['BYBIT_TESTNET_SECRET'],
  on_message: ->(msg) { puts msg.inspect }               # your handler
).connect

# Subscribe returns immediately; the actual `op:subscribe` frame is deferred
# until the private-stream auth reply lands, so you can call subscribe
# anytime — before or after `#connect`.
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
