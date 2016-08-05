# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 10.times do
#   User.create(
#     email: Faker::Internet.email
#     password: FFaker::Internet.password
#     role: "user"
#   )
# end
#
states = %w(new started finished)
30.times do
  Task.create(
    name: FFaker::Lorem.phrase(5),
    description: FFaker::Lorem.paragraph,
    # user_id: Random.new.rand(1..10),
    state: states.sample
  )
end
