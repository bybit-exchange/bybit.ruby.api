# frozen_string_literal: true

# End-to-end quickstart — public + signed calls + rescue matrix.
# Run with:  BYBIT_KEY=... BYBIT_SECRET=... ruby examples/quickstart.rb

require 'bybit'

Bybit.configure do |c|
  c.api_key    = ENV['BYBIT_KEY']
  c.api_secret = ENV['BYBIT_SECRET']
  c.testnet    = true          # flip to false for mainnet
end

client = Bybit::Client.new

# 1. Public endpoint — server time (no auth needed)
puts '--- server time ---'
puts client.market.get_server_time.inspect

# 2. Signed endpoint — wallet balance
puts '--- wallet balance ---'
begin
  wallet = client.account.get_wallet_balance(account_type: 'UNIFIED')
  puts wallet['result']['list'].inspect
rescue Bybit::AuthError => e
  warn "auth failed: [#{e.ret_code}] #{e.ret_msg}"
rescue Bybit::RateLimitError => e
  warn "rate-limited: #{e.ret_msg}"
rescue Bybit::TimeoutError => e
  warn "timeout: #{e.message}"
rescue Bybit::NetworkError => e
  warn "network: #{e.message}"
rescue Bybit::ApiError => e
  warn "api error [#{e.ret_code}]: #{e.ret_msg}"
end
