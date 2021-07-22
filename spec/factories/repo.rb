FactoryBot.define do
  factory :repo do
    name { Faker::Name.first_name }
    user { build(:user) }
  end
end
