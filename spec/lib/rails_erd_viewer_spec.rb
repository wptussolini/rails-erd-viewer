# frozen_string_literal: true

RSpec.describe RailsErdViewer do
  it 'defines the version constant' do
    expect(RailsErdViewer::VERSION).not_to be_nil
  end

  it 'loads the engine' do
    expect(RailsErdViewer::Engine).not_to be_nil
  end

  it 'requires the Railtie if Rails is defined' do
    expect { require 'rails_erd_viewer/railtie' }.not_to raise_error if defined?(Rails)
  end

  describe 'SchemaGenerator' do
    it 'can be accessed' do
      expect(RailsErdViewer::SchemaGenerator).not_to be_nil
    end
  end
end
