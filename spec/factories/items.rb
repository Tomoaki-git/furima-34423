FactoryBot.define do
  factory :item do
    item_name             {Faker::Lorem.sentence}
    description           {Faker::Lorem.sentence}
    category_id           {Faker::Number.between(from: 1, to: 10)}
    status_id             {Faker::Number.between(from: 1, to: 6)}
    which_delivery_fee_id {Faker::Number.between(from: 1, to: 2)}
    prefecture_id         {Faker::Number.between(from: 1, to: 47)}
    days_to_delivery_id   {Faker::Number.between(from: 1, to: 3)}
    price                 {Faker::Number.between(from: 300, to: 9999999)}
    association :user
  end
end