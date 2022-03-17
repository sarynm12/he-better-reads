class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews

  validates :title, :description, presence: true
end
