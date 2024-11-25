# frozen_string_literal: true

RSpec.describe 'db:migrate tasks' do # rubocop:disable Rspec/DescribeClass
  before do
    allow(ActiveRecord::Migration).to receive_messages(migrate: nil, rollback: nil)
    allow(ActiveRecord::Base.connection).to receive(:execute).and_return(nil)
    Rake.application.rake_require('tasks/db')
    Rake::Task.define_task(:environment)
    allow(RailsErdViewer::SchemaGenerator).to receive(:generate)
  end

  after do
    Rake::Task['db:migrate:up'].reenable
  end

  describe 'db:migrate:change' do
    it 'generates the ERD after a migration' do
      Rake.application.invoke_task('db:migrate:change')
      expect(RailsErdViewer::SchemaGenerator).to have_received(:generate).at_least(:once)
    end
  end

  describe 'db:migrate:down' do
    it 'generates the ERD after rolling back the migration' do
      ENV['VERSION'] = '20241108220456'
      Rake.application.invoke_task('db:migrate:down')
      expect(RailsErdViewer::SchemaGenerator).to have_received(:generate).at_least(:once)
    end
  end

  describe 'db:migrate:reset' do
    it 'generates the ERD after resetting the database' do
      Rake.application.invoke_task('db:migrate:reset')
      expect(RailsErdViewer::SchemaGenerator).to have_received(:generate).at_least(:once)
    end
  end

  describe 'db:migrate:up' do
    it 'generates the ERD after applying the migration' do
      ENV['VERSION'] = '20241108220456'
      Rake.application.invoke_task('db:migrate:up')
      expect(RailsErdViewer::SchemaGenerator).to have_received(:generate).at_least(:once)
    end
  end
end
