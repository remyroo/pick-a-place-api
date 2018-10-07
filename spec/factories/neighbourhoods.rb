FactoryBot.define do
  factory :neighbourhood do
    name { Faker::Address.community }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    radius { Faker::Number.number(4) }
  end
end
