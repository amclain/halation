require 'pry'
require 'rspec/its'
require 'coveralls'
require 'fileutils'

Coveralls.wear!

require_relative 'shared_examples/image_interface'
require_relative 'shared_examples/to_s_is_human_readable'

require 'halation'

RSpec.configure do |c|
  # Enable 'should' syntax
  c.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
  c.mock_with(:rspec)   { |c| c.syntax = [:should, :expect] }
  
  # Only run tests marked with focus: true.
  c.filter_run_including focus: true
  c.filter_run_excluding is_long_running: true if ENV["SKIP_LONG_TESTS"]
  c.run_all_when_everything_filtered = true
  
  # Abort after first failure.
  # (Use environment variable for developer preference)
  c.fail_fast = true if ENV['RSPEC_FAIL_FAST']
  
  # Set output formatter and enable color.
  c.formatter = 'Fivemat'
  c.color = true
end
