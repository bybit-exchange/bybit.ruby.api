# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('../fixtures/vcr_cassettes', __dir__)
  c.hook_into :webmock
  c.default_cassette_options = {
    # Strict replay: fail the spec if the outbound request doesn't match a
    # recorded interaction. Prevents accidentally hitting real Bybit endpoints
    # from CI when a cassette is missing or drifts.
    record: :none,
    # Match on method + URI + body so signature-payload assertions ride on the
    # cassette: if either the query string OR the JSON body drifts from what
    # the SDK signed on record day, the interaction won't match and the spec
    # fails. Headers are matched separately in the spec (see integration/*).
    match_requests_on: %i[method uri body]
  }
  # Redact any accidental live-secret capture in future cassette recordings.
  c.filter_sensitive_data('<API_KEY>')    { 'test-key' }
  c.filter_sensitive_data('<API_SECRET>') { 'test-secret' }
end
