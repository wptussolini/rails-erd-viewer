# frozen_string_literal: true

require 'rails_erd_viewer'
require 'rails'

module RailsErdViewer
  # RailsErdViewer::Railtie
  class Railtie < Rails::Railtie
    railtie_name :rails_erd_viewer

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
