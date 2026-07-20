# frozen_string_literal: true

require 'bybit'

Bybit.configure do |c|
  c.api_key    = ENV['BYBIT_KEY']
  c.api_secret = ENV['BYBIT_SECRET']
  c.testnet    = true
end

client = Bybit::Client.new
puts client.market.get_server_time.inspect
