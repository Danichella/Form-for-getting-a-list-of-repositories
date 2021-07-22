FactoryBot.define do
    factory :repo do
      name { Faker::Name.first_name }
    end
  end
  