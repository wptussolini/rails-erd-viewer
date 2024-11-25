# frozen_string_literal: true

module RailsErdViewer
  # RailsErdViewer::Engine
  class Engine < Rails::Engine
    isolate_namespace RailsErdViewer

    initializer 'rails_erd_viewer.assets.precompile' do |app|
      app.config.assets.precompile += %w[
        rails_erd_viewer/application.js
      ]
    end
  end
end
