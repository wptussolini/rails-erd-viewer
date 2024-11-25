# frozen_string_literal: true

module RailsErdViewer
  # RailsErd::ErdController
  class ErdController < RailsErdViewer::ApplicationController
    def index
      @schema = fetch_schema
    end

    private

    def fetch_schema
      schema_file_path = Rails.root.join('tmp/application_schema.sql')

      raise RailsErdViewer::MissingErdSchemaError unless File.exist?(schema_file_path)

      schema_data = File.read(schema_file_path)
      Base64.encode64(schema_data)
    end
  end
end
