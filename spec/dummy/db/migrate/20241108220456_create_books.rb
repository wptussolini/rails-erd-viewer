# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :summary
      t.references :author, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false
      t.references :publisher, foreign_key: true, null: false
      t.date :published_date

      t.timestamps
    end
  end
end
