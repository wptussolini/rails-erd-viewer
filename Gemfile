# frozen_string_literal: true

source 'http://rubygems.org'
gemspec

group :development, :test do
  case rails_version = ENV.fetch('RAILS_VERSION', nil)
  when nil
    gem 'rails'
  when 'edge'
    gem 'rails', github: 'rails/rails'
  else
    gem 'rails', "~> #{rails_version}.0"
  end

  gem 'codecov'
  gem 'rails-controller-testing'
  gem 'rake'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
  gem 'simplecov'
  gem 'sprockets-rails'
  gem 'sqlite3'
end
