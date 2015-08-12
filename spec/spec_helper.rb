$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib', 'sema_media_ruby')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'dotenv'
Dotenv.load

require 'sema_api_ruby'
require 'rspec'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
  c.configure_rspec_metadata!

  c.filter_sensitive_data('<ACCESS_TOKEN>') do |interaction|
    CGI.escape(test_access_token)
  end
end

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = false

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  Kernel.srand config.seed
end

def test_access_token
  ENV['TEST_ACCESS_TOKEN'] || 'testaccesstoken'
end

def api_client
  @api_client ||= SemaApiRuby.new(access_token: test_access_token)
end

def test_images_path
  File.join SemaApiRuby.root, 'spec', 'test_images'
end

def get_test_image_path(image_name)
  File.join test_images_path, image_name
end

