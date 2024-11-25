# frozen_string_literal: true

namespace :erd do
  desc 'Generate ERD Schema of the Database'
  task generate: :environment do
    RailsErdViewer::SchemaGenerator.generate
    puts 'ERD Schema generated successfully. You can view it at: http://localhost:3000/erd-viewer'
  end
end
