User.first_or_create!(
  email: Faker::Internet.email,
  username: Faker::Internet.username(3..15),
  password: 'password'
)
