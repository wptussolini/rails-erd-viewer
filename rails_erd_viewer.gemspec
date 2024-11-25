# frozen_string_literal: true

require File.expand_path('lib/rails_erd_viewer/version', __dir__)
Gem::Specification.new do |spec|
  spec.name = 'rails_erd_viewer'
  spec.version = RailsErdViewer::VERSION
  spec.authors = ['Phelipe Tussolini']
  spec.email = ['wp.tussolini@gmail.com']
  spec.summary = 'A gem to visualize Entity-Relationship Diagram from your rails application.'
  spec.description = 'RailsERD Viewer helps developers visualize ERDs, making database relationships clearer.'
  spec.homepage = 'https://github.com/wptussolini/rails-erd'
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'
  spec.files = Dir["{app,config,lib}/**/*"]
  spec.extra_rdoc_files = ['README.md']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
