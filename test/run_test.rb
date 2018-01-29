require 'bundler/setup'
require 'test/unit'
require 'active_record'

### Take care of autoloading all the dependencies needed to run the tests ###

Bundler.require(:default, :test)

base_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
test_dir = File.join(base_dir, 'test')

def require_paths(base_dir, paths)
  paths.each do |path|
    Dir[File.join(base_dir, path)].each { |f| require f }
  end
end

require_paths(base_dir, %w[
  app/models/*.rb
  lib/**/*.rb
])

### Configure VCR to use HTTP fixtures so that we won't use network during testing ###

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end

### Set up database connection ###

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/test.sqlite3'
)

ActiveRecord::Migrator.migrate('db/migrate/')

### Execute test files ###

exit Test::Unit::AutoRunner.run(true, test_dir)
