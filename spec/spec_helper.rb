require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'spec/'
  add_filter '.github/'
  add_filter 'lib/generators/templates/'
  add_filter 'lib/rails_erd_viewer/version'
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

ENV['RAILS_ENV'] = 'test'

require 'rake'

require File.expand_path('dummy/config/environment', __dir__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../spec/dummy/db/migrate', __dir__)]

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.before(:suite) do
    Rails.application.load_tasks
    Rake::Task['db:test:prepare'].invoke
  end

  schema_path = 'spec/dummy/tmp/application_schema.sql'
  config.before do
    FileUtils.rm_f(schema_path)
  end
end
