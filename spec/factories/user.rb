FactoryBot.define do
  factory :user do
    login { Faker::Internet.username }
    name { Faker::Name.first_name }
  end
end
