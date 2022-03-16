class Review < ApplicationRecord
  validates :rating, numericality: { in: 1..5 }
  validates :description, presence: false

  belongs_to :user
  belongs_to :book
end