# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true, uniqueness: true
end
