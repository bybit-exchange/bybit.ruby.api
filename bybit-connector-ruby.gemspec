# frozen_string_literal: true

require_relative 'lib/bybit/version'

Gem::Specification.new do |s|
  s.name          = 'bybit-connector-ruby'
  s.version       = Bybit::VERSION
  s.summary       = 'Official Bybit V5 REST API connector for Ruby'
  s.description   = 'Ruby connector for the Bybit V5 REST API — keyword-arg method signatures, HMAC-SHA256 signing, typed error hierarchy, Faraday-based transport.'
  s.authors       = ['Bybit']
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/bybit-exchange/bybit.ruby.api'
  s.required_ruby_version = '>= 3.0'
  s.files         = Dir['lib/**/*.rb', 'LICENSE*', 'README.md', 'CHANGELOG.md', 'examples/**/*.rb']
  s.require_paths = ['lib']
  s.metadata      = {
    'source_code_uri'       => 'https://github.com/bybit-exchange/bybit.ruby.api',
    'documentation_uri'     => 'https://bybit-exchange.github.io/docs/v5/intro',
    'changelog_uri'         => 'https://github.com/bybit-exchange/bybit.ruby.api/blob/main/CHANGELOG.md',
    'rubygems_mfa_required' => 'true'
  }
  s.add_dependency 'faraday', '~> 2.0'
  s.add_development_dependency 'rspec',     '~> 3.12'
  s.add_development_dependency 'rubocop',   '~> 1.60'
  s.add_development_dependency 'yard',      '~> 0.9'
  s.add_development_dependency 'webmock',   '~> 3.0'
  s.add_development_dependency 'simplecov', '~> 0.22'
end
