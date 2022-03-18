class Review < ApplicationRecord
  validates :rating, presence: true
  validates_numericality_of :rating, greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  validates :description, presence: false

  belongs_to :user
  belongs_to :book

  validates :book_id, uniqueness: { scope: :user_id, message: "you've already reviewed" }

  def self.sorted(order = "DESC")
    order(rating: order)
  end
end