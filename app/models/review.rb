class Review < ApplicationRecord
  validates :rating, numericality: { in: 1..5 }
  validates :description, allow_nil: true

  belongs_to :user
  belongs_to :book
end