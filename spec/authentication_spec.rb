# frozen_string_literal: true

# Regression tests around `Bybit::Authentication.sign_v5`. The known-vector
# assertions below LOCK the exact byte concatenation order — timestamp,
# api_key, recv_window, payload — plus HMAC-SHA256 hex digest. If any of
# these ever drift, every signed call goes 401.
RSpec.describe Bybit::Authentication do
  describe '.sign_v5' do
    # Fixed inputs — signature is deterministic given these inputs.
    let(:api_secret)  { 'test-secret' }
    let(:api_key)     { 'test-key' }
    let(:timestamp)   { '1700000000000' }
    let(:recv_window) { '5000' }

    it 'HMAC-SHA256 hex-digests timestamp + apiKey + recvWindow + payload for GET query strings' do
      payload = 'category=spot&symbol=BTCUSDT'
      expected = OpenSSL::HMAC.hexdigest(
        'SHA256', api_secret, "#{timestamp}#{api_key}#{recv_window}#{payload}"
      )
      expect(described_class.sign_v5(api_secret, timestamp, api_key, recv_window, payload)).to eq(expected)
    end

    it 'HMAC-SHA256 hex-digests the JSON body verbatim for POST payloads' do
      payload = '{"category":"linear","symbol":"BTCUSDT"}'
      expected = OpenSSL::HMAC.hexdigest(
        'SHA256', api_secret, "#{timestamp}#{api_key}#{recv_window}#{payload}"
      )
      expect(described_class.sign_v5(api_secret, timestamp, api_key, recv_window, payload)).to eq(expected)
    end

    it 'produces a 64-char lowercase hex string' do
      sig = described_class.sign_v5(api_secret, timestamp, api_key, recv_window, '')
      expect(sig).to match(/\A[0-9a-f]{64}\z/)
    end
  end
end
