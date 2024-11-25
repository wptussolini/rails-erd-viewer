# frozen_string_literal: true

class CreatePublishers < ActiveRecord::Migration[8.0]
  def change
    create_table :publishers do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
