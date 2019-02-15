FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(3..15) }
    password { 'password' }

    trait :admin do
      role { 'admin' }
    end
  end
end
