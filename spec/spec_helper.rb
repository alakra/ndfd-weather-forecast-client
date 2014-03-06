ENV["ENV"] = "test"

require 'ndfd'

Bundler.require(:default, NDFD.env)

Time.zone = 'UTC'

require 'webmock/rspec'
require 'vcr'
require 'savon'
require 'byebug'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock

  c.configure_rspec_metadata!
  c.ignore_localhost                        = true
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = {
    :allow_playback_repeats => true,
    :match_requests_on => [:method, :uri, :headers]
  }
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end