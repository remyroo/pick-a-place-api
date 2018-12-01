FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(3..15) }
    password { Faker::Internet.password(6, 12) }

    trait :admin do
      admin { true }
    end
  end
end
