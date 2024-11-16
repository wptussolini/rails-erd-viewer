class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher

  validates :title, presence: true
end
