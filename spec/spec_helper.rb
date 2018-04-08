require "simplecov"

SimpleCov.start do
  root File.join(File.dirname(__FILE__), '..')
  add_filter '/spec/'
  add_group 'Libraries', 'lib'
#  add_group 'Services', 'lib/*'
end

require "bundler/setup"
require "endpoint_benchmark"

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
