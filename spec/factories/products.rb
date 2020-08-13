FactoryBot.define do
  factory :product do
    description { Faker::Commerce.product_name }
    association :merchant
  end
end
