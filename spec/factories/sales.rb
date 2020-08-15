FactoryBot.define do
  factory :sale do
    association :purchaser
    association :sale_import
  end
end
