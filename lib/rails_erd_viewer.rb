# frozen_string_literal: true

require_relative 'rails_erd_viewer/version'
require 'rails_erd_viewer/engine'
require_relative 'rails_erd_viewer/schema_generator'
module RailsErdViewer
  require 'rails_erd_viewer/railtie' if defined?(Rails)
  class MissingErdSchemaError < StandardError; end
end
