# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsErdViewer::Engine => '/erd-viewer', as: 'rails_erd_viewer_engine'
  get 'erd-viewer' => 'rails_erd_viewer/erd#index'
end
