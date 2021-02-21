FactoryBot.define do
  factory :user do
    email                   {Faker::Internet.unique.free_email}
    nickname                {Faker::Name.initials(number: 4)}
    password                { '1a' +Faker::Internet.password(min_length: 6) }
    password_confirmation   {password}
    family_name             {Gimei.name.last}
    first_name              {Gimei.name.first}
    family_name_kana        {Gimei.name.last.katakana}
    first_name_kana         {Gimei.name.first.katakana}
    birthday                {Faker::Date.birthday(min_age: 18, max_age: 65)}
  end
end