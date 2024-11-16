# frozen_string_literal: true

RSpec.describe 'erd:generate' do
  describe 'generate_erd_after_migrate' do
    it 'gera o ERD após uma migração' do
      expect(RailsErdViewer::SchemaGenerator).to receive(:generate)

      Rake::Task['erd:generate'].invoke
    end
  end
end
