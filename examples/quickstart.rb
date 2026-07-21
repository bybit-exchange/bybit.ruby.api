# frozen_string_literal: true

# End-to-end quickstart — mirrors README's Quick Start:
#   1. public unsigned call
#   2. signed GET (wallet balance)
#   3. safe LIMIT order well below market (does not fill)
#   4. cancel that order
# Run with:
#   BYBIT_TESTNET_KEY=... BYBIT_TESTNET_SECRET=... ruby examples/quickstart.rb

require 'bybit'

Bybit.configure do |c|
  c.api_key    = ENV.fetch('BYBIT_TESTNET_KEY')
  c.api_secret = ENV.fetch('BYBIT_TESTNET_SECRET')
  c.testnet    = true          # flip to false for mainnet — see README warning
end

client = Bybit::Client.new

# 1. Public endpoint — server time (no auth needed).
puts '--- server time ---'
puts client.market.get_server_time.inspect

# 2. Signed endpoint — wallet balance.
puts '--- wallet balance ---'
begin
  wallet = client.account.get_wallet_balance(account_type: 'UNIFIED')
  puts wallet['result']['list'].inspect
rescue Bybit::AuthError => e
  warn "auth failed: [#{e.ret_code}] #{e.ret_msg}"
  exit 1
rescue Bybit::RateLimitError => e
  warn "rate-limited: #{e.ret_msg}"
rescue Bybit::TimeoutError => e
  warn "timeout: #{e.message}"
rescue Bybit::NetworkError => e
  warn "network: #{e.message}"
rescue Bybit::ApiError => e
  warn "api error [#{e.ret_code}]: #{e.ret_msg}"
end

# 3. Place a LIMIT order well below market so it sits on the book and does
#    NOT fill (safe to run repeatedly). Adjust price if BTC ever trades that
#    low; otherwise this stays a resting order you can cancel below.
puts '--- place limit order ---'
begin
  order = client.trade.create_order(
    category: 'linear', symbol: 'BTCUSDT',
    side: 'Buy', order_type: 'Limit', qty: '0.01',
    price: '10000', time_in_force: 'GTC'
  )
  order_id = order['result']['orderId']
  puts "orderId: #{order_id}"

  # 4. Cancel it before exiting so we don't leave test orders on the book.
  puts '--- cancel order ---'
  cancel = client.trade.cancel_order(
    category: 'linear', symbol: 'BTCUSDT', order_id: order_id
  )
  puts cancel['result'].inspect
rescue Bybit::ApiError => e
  warn "api error [#{e.ret_code}]: #{e.ret_msg}"
end
