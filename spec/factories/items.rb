FactoryBot.define do
  factory :item do
    price { Faker::Commerce.price }
    count { SecureRandom.rand(1..30) }
    association :sale
    association :product
  end
end
