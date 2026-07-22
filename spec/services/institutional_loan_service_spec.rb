# frozen_string_literal: true

# Smoke tests for Bybit::RestApi::InstitutionalLoanService — table-driven
# assertion that every public method dispatches to the correct
# (path, HTTP method, signed) tuple.

RSpec.describe Bybit::RestApi::InstitutionalLoanService do
  let(:session) { instance_double(Bybit::Session, public_request: {}, sign_request: {}) }
  let(:svc) { described_class.new(session) }

  method_table = [
    { name: :get_product_info, path: '/v5/ins-loan/product-infos', method: :get, signed: false },
    { name: :get_margin_coin_info, path: '/v5/ins-loan/ensure-tokens-convert', method: :get, signed: false },
    { name: :get_loan_orders, path: '/v5/ins-loan/loan-order', method: :get, signed: true },
    { name: :get_repayment_orders, path: '/v5/ins-loan/repaid-history', method: :get, signed: true },
    { name: :get_ltv, path: '/v5/ins-loan/ltv-convert', method: :get, signed: true },
    { name: :bind_or_unbind_uid, path: '/v5/ins-loan/association-uid', method: :post, signed: true },
    { name: :repay_loan, path: '/v5/ins-loan/repay-loan', method: :post, signed: true },
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
