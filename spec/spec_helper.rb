# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/examples/'
  # Signing + transport layer must stay tight — fail CI if either drops.
  minimum_coverage_by_file 'lib/bybit/authentication.rb' => 100
  minimum_coverage_by_file 'lib/bybit/session.rb' => 90
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
