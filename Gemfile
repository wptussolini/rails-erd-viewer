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

  gem 'codecov', '~> 0.6'
  gem 'rails-controller-testing'
  gem 'rake', '~> 13.0'
  gem 'rspec', '~> 3.13'
  gem 'rspec-rails', '~> 7'
  gem 'rubocop', '~> 1.68.0'
  gem 'rubocop-performance', '~> 1.20'
  gem 'rubocop-rspec', '~> 3.2.0'
  gem 'simplecov', '~> 0.20'
  gem 'sprockets-rails', '~> 3.5.2'
  gem 'sqlite3'
end
