# frozen_string_literal: true

RSpec.describe 'db:migrate tasks' do
  before do
    allow(ActiveRecord::Migration).to receive_messages(migrate: nil, rollback: nil)
    allow(ActiveRecord::Base.connection).to receive(:execute).and_return(nil)
  end

  describe 'db:migrate:change' do
    it 'generates the ERD after a migration' do
      expect(RailsErdViewer::SchemaGenerator).to receive(:generate).at_least(:once)
      Rake.application.invoke_task('db:migrate:change')
    end
  end

  describe 'db:migrate:down' do
    it 'generates the ERD after rolling back the migration' do
      ENV['VERSION'] = '20241108220456'
      expect(RailsErdViewer::SchemaGenerator).to receive(:generate).at_least(:once)
      Rake.application.invoke_task('db:migrate:down')
    end
  end

  describe 'db:migrate:reset' do
    it 'generates the ERD after resetting the database' do
      expect(RailsErdViewer::SchemaGenerator).to receive(:generate).at_least(:once)
      Rake.application.invoke_task('db:migrate:reset')
    end
  end

  describe 'db:migrate:up' do
    it 'generates the ERD after applying the migration' do
      ENV['VERSION'] = '20241108220456'
      expect(RailsErdViewer::SchemaGenerator).to receive(:generate).at_least(:once)
      Rake.application.invoke_task('db:migrate:up')
    end
  end
end
