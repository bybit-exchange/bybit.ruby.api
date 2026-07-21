# frozen_string_literal: true

# Smoke tests for Bybit::RestApi::MiscService.

RSpec.describe Bybit::RestApi::MiscService do
  let(:session) { instance_double(Bybit::Session, public_request: {}, sign_request: {}) }
  let(:svc) { described_class.new(session) }

  method_table = [
    { name: :get_announcements, path: '/v5/announcements/index', method: :get, signed: false },
    { name: :get_system_status, path: '/v5/system/status', method: :get, signed: false },
  ].freeze

  method_table.each do |row|
    describe "##{row[:name]}" do
      it "dispatches #{row[:method].upcase} #{row[:path]} (signed=#{row[:signed]})" do
        target = row[:signed] ? :sign_request : :public_request
        expect(session).to receive(target) do |**kw|
          expect(kw[:path]).to eq(row[:path])
          if row[:signed] || row[:method] != :get
            expect(kw[:method]).to eq(row[:method]) if kw.key?(:method)
          end
          {}
        end
        method = svc.method(row[:name])
        required_kw = method.parameters.select { |t, _| t == :keyreq }.map { |_, n| [n, ''] }.to_h
        svc.public_send(row[:name], **required_kw)
      end
    end
  end
end
