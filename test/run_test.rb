require 'bundler/setup'
require 'test/unit'

Bundler.require(:default, :test)

base_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
test_dir = File.join(base_dir, 'test')

def require_paths(base_dir, paths)
  paths.each do |path|
    Dir[File.join(base_dir, path)].each { |f| require f }
  end
end

require_paths(base_dir, %w[
  lib/**/*.rb
])

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

exit Test::Unit::AutoRunner.run(true, test_dir)
