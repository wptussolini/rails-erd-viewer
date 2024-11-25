# frozen_string_literal: true

RSpec.describe 'Rake task: erd:generate' do # rubocop:disable Rspec/DescribeClass
  describe 'executing task' do
    it 'calls SchemaGenerator to generate ERD' do
      allow(RailsErdViewer::SchemaGenerator).to receive(:generate)

      Rake::Task['erd:generate'].invoke
      expect(RailsErdViewer::SchemaGenerator).to have_received(:generate)
    end
  end
end
