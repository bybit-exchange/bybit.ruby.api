# frozen_string_literal: true

module Bybit
  module RestApi
    class TaxService < BaseService
      # Batch create tax report files
      #
      # POST /v5/fht/compliance/tax/private/batch_create
      #
      # @param start_time [Integer] Tax report start time (Unix timestamp, seconds)
      # @param end_time [Integer] Tax report end time (Unix timestamp, seconds); interval must not exceed 12 months
      # @param items [Array] Non-empty list of tax report export items
      # @option kwargs [String] :source_institution Optional source institution identifier
      # @option kwargs [String] :export_file_type Export file format:
      #   - `csv` — CSV text format
      #   - `orc` — ORC columnar format (default)
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/fht/compliance/tax/private/batch_create
      def batch_create_tax_reports(start_time:, end_time:, items:, **kwargs)
        params = Bybit::Utils::WireKeys.camelize(kwargs.merge(startTime: start_time, endTime: end_time, items: items))
        @session.sign_request(method: :post, path: '/v5/fht/compliance/tax/private/batch_create', body: params)
      end

      # Query batch tax report status
      #
      # GET /v5/fht/compliance/tax/private/batch_query
      #
      # @param batch_id [String] Batch ID returned by `batch_create`
      # @return [Hash] Bybit V5 ApiResponse envelope (retCode / retMsg / result / retExtInfo / time).
      # @see https://bybit-exchange.github.io/docs/v5/fht/compliance/tax/private/batch_query
      def batch_query_tax_reports(batch_id:)
        params = Bybit::Utils::WireKeys.camelize({ batchId: batch_id })
        @session.sign_request(method: :get, path: '/v5/fht/compliance/tax/private/batch_query', params: params)
      end
    end
  end
end
