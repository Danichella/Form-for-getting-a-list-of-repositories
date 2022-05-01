FactoryBot.define do
  factory :user do
    login { Faker::Internet.username }
    name { Faker::Name.first_name }
    profile_url { nil }
    avatar_url { nil }
  end
end
