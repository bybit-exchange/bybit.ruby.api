# frozen_string_literal: true

RSpec.describe Bybit::Utils::WireKeys do
  describe '.camelize' do
    it 'converts top-level snake_case keys to camelCase (symbols)' do
      expect(described_class.camelize(order_type: 'Limit', symbol: 'BTCUSDT'))
        .to eq(orderType: 'Limit', symbol: 'BTCUSDT')
    end

    it 'recurses into nested Hash values' do
      input  = { extra: { stake_amount: '1', account_type: 'UNIFIED' } }
      output = { extra: { stakeAmount: '1', accountType: 'UNIFIED' } }
      expect(described_class.camelize(input)).to eq(output)
    end

    it 'recurses into Array-of-Hash values (batch endpoints)' do
      input  = { request: [{ order_type: 'Limit', symbol: 'BTCUSDT' }, { order_type: 'Market', symbol: 'ETHUSDT' }] }
      output = { request: [{ orderType: 'Limit', symbol: 'BTCUSDT' }, { orderType: 'Market', symbol: 'ETHUSDT' }] }
      expect(described_class.camelize(input)).to eq(output)
    end

    it 'passes non-Hash / non-Array-of-Hash values through unchanged' do
      expect(described_class.camelize(symbols: %w[BTCUSDT ETHUSDT], count: 5))
        .to eq(symbols: %w[BTCUSDT ETHUSDT], count: 5)
    end

    it 'rewrites reserved-word aliases (end_ → end)' do
      expect(described_class.camelize(end_: 123)).to eq(end: 123)
      expect(described_class.camelize(begin_: 1, end_: 2)).to eq(begin: 1, end: 2)
    end
  end
end
