require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
end
require 'database_cleaner'
require 'vcr'


RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :webmock
    config.default_cassette_options = {
        match_requests_on: [:uri, :body, :method]
    }
  end
end
