# frozen_string_literal: true

require 'bybit/websocket/client'

# Unit tests exercise the WebSocket client with the underlying
# `WebSocket::Client::Simple` stubbed out — WebMock cannot help here (it only
# intercepts HTTP), so we swap the `connect` factory with a fake socket that
# captures frames and lets us fire synthetic on_open / on_message callbacks.
RSpec.describe Bybit::WebSocket::Client do
  # Minimal ws double: records outbound frames, exposes handler map so tests
  # can invoke on_open / on_message / on_close.
  class FakeWs
    attr_reader :sent, :handlers

    def initialize
      @sent = []
      @handlers = {}
      @closed = false
    end

    def on(event, &block)
      @handlers[event] = block
    end

    def send(msg)
      @sent << msg
    end

    def close
      @closed = true
      @handlers[:close]&.call(nil)
    end

    def fire(event, arg = nil)
      @handlers[event]&.call(arg)
    end
  end

  let(:fake_ws) { FakeWs.new }

  before do
    # The real `WebSocket::Client::Simple.connect` opens a socket + spins up
    # a reader thread — swap it for a FakeWs that records outbound frames
    # and lets the test fire synthetic on_open / on_message callbacks.
    allow(::WebSocket::Client::Simple).to receive(:connect).and_return(fake_ws)
  end

  describe 'channel validation' do
    it 'accepts each documented public channel' do
      %i[spot linear inverse option].each do |ch|
        expect { described_class.new(channel: ch) }.not_to raise_error
      end
    end

    it 'accepts :private and :trade' do
      expect { described_class.new(channel: :private, api_key: 'k', api_secret: 's') }.not_to raise_error
      expect { described_class.new(channel: :trade, api_key: 'k', api_secret: 's') }.not_to raise_error
    end

    it 'rejects unknown channels' do
      expect { described_class.new(channel: :spread) }.to raise_error(Bybit::ConfigurationError, /invalid channel/)
    end
  end

  describe 'URL selection' do
    it 'points at mainnet by default' do
      expect(described_class.new(channel: :linear).url).to eq('wss://stream.bybit.com/v5/public/linear')
    end

    it 'points at stream-testnet when testnet: true' do
      expect(described_class.new(channel: :spot, testnet: true).url)
        .to eq('wss://stream-testnet.bybit.com/v5/public/spot')
    end

    it 'respects a caller-supplied url override' do
      cli = described_class.new(channel: :linear, url: 'wss://custom.example.com/x')
      expect(cli.url).to eq('wss://custom.example.com/x')
    end
  end

  describe 'public subscribe flow' do
    it 'buffers topics before connect and flushes on open' do
      cli = described_class.new(channel: :linear).subscribe('tickers.BTCUSDT', 'orderbook.1.BTCUSDT')
      expect(fake_ws.sent).to be_empty  # not sent — socket isn't connected
      cli.connect
      fake_ws.fire(:open)
      expect(fake_ws.sent.size).to eq(1)
      frame = JSON.parse(fake_ws.sent.first)
      expect(frame['op']).to eq('subscribe')
      expect(frame['args']).to contain_exactly('tickers.BTCUSDT', 'orderbook.1.BTCUSDT')
    end

    it 'de-duplicates topics across multiple subscribe calls' do
      cli = described_class.new(channel: :linear)
      cli.subscribe('tickers.BTCUSDT')
      cli.subscribe('tickers.BTCUSDT', 'tickers.ETHUSDT')
      expect(cli.subscriptions).to contain_exactly('tickers.BTCUSDT', 'tickers.ETHUSDT')
    end

    it 'delivers messages to on_message as parsed hashes' do
      seen = []
      cli = described_class.new(channel: :linear, on_message: ->(m) { seen << m })
      cli.connect
      fake_ws.fire(:open)
      fake_ws.fire(:message, double(data: '{"topic":"tickers.BTCUSDT","data":{"lastPrice":"30000"}}'))
      expect(seen.first).to eq({ 'topic' => 'tickers.BTCUSDT', 'data' => { 'lastPrice' => '30000' } })
    end

    it 'passes raw string to on_message when body is not JSON' do
      seen = []
      cli = described_class.new(channel: :linear, on_message: ->(m) { seen << m })
      cli.connect
      fake_ws.fire(:open)
      fake_ws.fire(:message, double(data: 'not-json'))
      expect(seen.first).to eq('not-json')
    end
  end

  describe 'private-stream auth' do
    it 'requires api_key + api_secret before connect' do
      cli = described_class.new(channel: :private)
      expect { cli.connect }.to raise_error(Bybit::ConfigurationError, /api_key/)
    end

    it 'sends an auth frame on open and defers subscribe until auth OK' do
      cli = described_class.new(channel: :private, api_key: 'key', api_secret: 'secret')
      cli.subscribe('position')
      cli.connect
      fake_ws.fire(:open)
      # First frame is auth, subscribe waits for the ack.
      expect(fake_ws.sent.size).to eq(1)
      auth = JSON.parse(fake_ws.sent.first)
      expect(auth['op']).to eq('auth')
      expect(auth['args'].first).to eq('key')
      expect(auth['args'][2]).to match(/\A[a-f0-9]{64}\z/)

      # Auth success — subscribe should now flush.
      fake_ws.fire(:message, double(data: '{"op":"auth","success":true}'))
      sub = JSON.parse(fake_ws.sent.last)
      expect(sub).to eq({ 'op' => 'subscribe', 'args' => ['position'] })
    end

    it 'does not flush subs if auth is rejected' do
      cli = described_class.new(channel: :private, api_key: 'k', api_secret: 's')
      cli.subscribe('position')
      cli.connect
      fake_ws.fire(:open)
      fake_ws.fire(:message, double(data: '{"op":"auth","success":false,"retMsg":"bad sig"}'))
      expect(fake_ws.sent.size).to eq(1)  # only the auth frame
    end
  end

  describe 'unsubscribe / disconnect' do
    it 'sends an unsubscribe frame and drops the topic' do
      cli = described_class.new(channel: :linear).subscribe('tickers.BTCUSDT')
      cli.connect
      fake_ws.fire(:open)
      fake_ws.sent.clear
      cli.unsubscribe('tickers.BTCUSDT')
      expect(JSON.parse(fake_ws.sent.first)).to eq({ 'op' => 'unsubscribe', 'args' => ['tickers.BTCUSDT'] })
      expect(cli.subscriptions).to be_empty
    end

    it 'closes the socket on disconnect' do
      cli = described_class.new(channel: :linear).connect
      fake_ws.fire(:open)
      cli.disconnect
      expect(cli.connected?).to eq(false)
    end

    it 'suppresses on_error during a deliberate disconnect' do
      # The underlying ws-client-simple reader thread emits IOError when we
      # close from the main thread; without the @closing gate that would leak
      # into on_error and look like a real transport failure.
      errors = []
      cli = described_class.new(channel: :linear, on_error: ->(e) { errors << e }).connect
      fake_ws.fire(:open)
      cli.disconnect
      fake_ws.fire(:error, IOError.new('stream closed in another thread'))
      expect(errors).to be_empty
    end
  end

  describe 'idempotent connect' do
    it 'tears down the prior socket + ping thread before opening a new one' do
      cli = described_class.new(channel: :linear).connect
      fake_ws.fire(:open)
      first_ws = fake_ws

      # Second `connect`: the client must call close on the previous ws and
      # request a fresh one. Swap the factory to return a distinct fake and
      # assert the old one was closed and replaced.
      second_ws = FakeWs.new
      allow(::WebSocket::Client::Simple).to receive(:connect).and_return(second_ws)

      cli.connect
      expect(first_ws.instance_variable_get(:@closed)).to eq(true)
      # Fresh socket wired up so a fired :open reaches the client.
      second_ws.fire(:open)
      expect(cli.connected?).to eq(true)
    end

    it 'replays buffered subscriptions after a reconnect' do
      cli = described_class.new(channel: :linear).subscribe('tickers.BTCUSDT')
      cli.connect
      fake_ws.fire(:open)
      expect(cli.subscriptions).to include('tickers.BTCUSDT')

      second_ws = FakeWs.new
      allow(::WebSocket::Client::Simple).to receive(:connect).and_return(second_ws)
      cli.connect
      second_ws.fire(:open)

      # First frame on the new socket is a subscribe replaying the topic.
      first_frame = JSON.parse(second_ws.sent.first)
      expect(first_frame['op']).to eq('subscribe')
      expect(first_frame['args']).to include('tickers.BTCUSDT')
    end
  end
end
