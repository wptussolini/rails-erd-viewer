# frozen_string_literal: true

namespace :db do
  namespace :migrate do
    %i[change up down reset redo].each do |t|
      task t => :environment do # rubocop:disable
        RailsErdViewer::SchemaGenerator.generate
      end
    end
  end
end
