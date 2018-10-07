# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    name { Faker::Restaurant.name }
    address { Faker::Address.full_address }
    opening_hours { "Mon-Sun: 7.30am - 8.pm" }
    website_url { Faker::Internet.url }
    photo { Faker::Internet.url }
    venue_category { Faker::Restaurant.type }
    price_range { Faker::Number.between(1, 5) }
    rating { Faker::Number.between(1, 5) }
  end
end
