FactoryBot.define do
  factory :buyer_shipping_add do
    postal_code           {'123-4567'}
    prefecture_id         {Faker::Number.between(from: 1, to: 47)}
    municipalities        {Faker::Lorem.sentence}
    address               {Faker::Lorem.sentence}
    building              {Faker::Lorem.sentence}
    tel                   {'09012345678'}
    token                 {'tok_abcdefghijk00000000000000000'}
  end
end
