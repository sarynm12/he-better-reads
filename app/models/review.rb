class Review < ApplicationRecord
  validates_numericality_of :rating, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  validates :description, presence: false

  belongs_to :user
  belongs_to :book
end