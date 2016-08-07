require 'ffaker'

desc 'add10 users and 30 tasks'
  task :fake_data => :environment do
    10.times do
      User.create(
        email: FFaker::Internet.email,
        password: "user12345",
        role: "user"
      )
    end

    30.times do
      Task.create(
        name: FFaker::Lorem.phrase(5),
        description: FFaker::Lorem.paragraph,
        user_id: Random.new.rand(1..10)
      )
    end

    p "added 10 users and 30 tasks"
  end
