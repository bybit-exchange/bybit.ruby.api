# frozen_string_literal: true

RSpec.describe Bybit do
  it 'has a version number' do
    expect(Bybit::VERSION).not_to be_nil
  end

  it 'builds a client with defaults' do
    Bybit.configure { |c| c.testnet = true }
    client = Bybit::Client.new
    expect(client).to be_a(Bybit::Client)
  end
end
