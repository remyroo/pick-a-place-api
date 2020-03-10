User.first_or_create!(
  email: 'admin@example.com',
  username: 'admin',
  password: 'password',
  role: 'admin'
)
