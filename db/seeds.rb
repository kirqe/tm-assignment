# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: 'admin@example.com',
  password: 'admin12345',
  role: 'admin'
)

demo_user = User.create(
  email: 'user@example.com',
  password: 'user12345',
  role: 'user'
)

7.times do
  Task.create(
    name: FFaker::Lorem.phrase(5),
    description: FFaker::Lorem.paragraph,
    user: demo_user
  )
end
