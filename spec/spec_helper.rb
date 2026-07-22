# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/examples/'
end

# Signing + transport layer must stay tight — fail CI if either drops.
# SimpleCov's `minimum_coverage_by_file` only accepts a single global percentage
# (or a criterion hash), not per-file thresholds — enforce them by hand.
# Explicit files pin the signing + transport bar. Every rest_api/*_service.rb
# gets a floor bar via the directory-wide check below — landing a new service
# without a matching spec drops CI immediately.
PER_FILE_COVERAGE_GATES = {
  'lib/bybit/authentication.rb' => 100.0,
  'lib/bybit/session.rb' => 90.0
}.freeze
SERVICE_FILE_COVERAGE_FLOOR = 80.0

SimpleCov.at_exit do
  SimpleCov.result.format!
  failed = PER_FILE_COVERAGE_GATES.filter_map do |path, threshold|
    file = SimpleCov.result.files.find { |f| f.filename.end_with?(path) }
    next "#{path}: not tracked by SimpleCov" if file.nil?
    next if file.covered_percent >= threshold

    format('%<path>s: %<pct>.2f%% < %<req>.2f%%', path: path, pct: file.covered_percent, req: threshold)
  end

  # Service files: every rest_api/*_service.rb must meet the floor. base_service
  # is skipped (a two-line initializer with nothing meaningful to cover).
  SimpleCov.result.files.each do |file|
    next unless file.filename.include?('/lib/bybit/rest_api/')
    next if file.filename.end_with?('/base_service.rb')
    next if file.covered_percent >= SERVICE_FILE_COVERAGE_FLOOR

    rel = file.filename.sub(%r{^.*/lib/}, 'lib/')
    failed << format('%<path>s: %<pct>.2f%% < %<req>.2f%%',
                     path: rel, pct: file.covered_percent, req: SERVICE_FILE_COVERAGE_FLOOR)
  end

  unless failed.empty?
    warn "SimpleCov per-file coverage gate failed:\n  #{failed.join("\n  ")}"
    exit 1
  end
end

require 'bybit'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
