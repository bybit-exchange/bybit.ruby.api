# frozen_string_literal: true

# Smoke tests for Bybit::RestApi::PreUpgradeService.

RSpec.describe Bybit::RestApi::PreUpgradeService do
  let(:session) { instance_double(Bybit::Session, public_request: {}, sign_request: {}) }
  let(:svc) { described_class.new(session) }

  method_table = [
    { name: :get_order_history, path: '/v5/pre-upgrade/order/history', method: :get, signed: true },
    { name: :get_trade_history, path: '/v5/pre-upgrade/execution/list', method: :get, signed: true },
    { name: :get_closed_pnl, path: '/v5/pre-upgrade/position/closed-pnl', method: :get, signed: true },
    { name: :get_transaction_log, path: '/v5/pre-upgrade/account/transaction-log', method: :get, signed: true },
    { name: :get_option_delivery_record, path: '/v5/pre-upgrade/asset/delivery-record', method: :get, signed: true },
    { name: :get_usdc_session_settlement, path: '/v5/pre-upgrade/asset/settlement-record', method: :get, signed: true },
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
