FactoryBot.define do
  factory :review do
    book
    user
    rating { Faker::Number.between(from: 1, to: 5) }
    description { Faker::Movies::HarryPotter.quote }
  end
end