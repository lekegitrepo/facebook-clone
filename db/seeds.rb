# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

24.times do
  first_name  = Faker::Name.name
  last_name  = Faker::Name.name
  email = Faker::Internet.email
  username  = Faker::Name.name
  password = 'password'
  fake_user = User.create!(first_name:  first_name, last_name: last_name,
               username: username,
               email: email,
               password:              password,
               password_confirmation: password)

  10.times do
        fake_user.posts.create(content: Faker::Lorem.paragraph)
    end
end

Post.all.each do |p|
   users = User.all.sample(4)
   users.each do |u|
    u.comments.create(comment: Faker::Lorem.sentence(5), post_id: p.id)
   end
end
