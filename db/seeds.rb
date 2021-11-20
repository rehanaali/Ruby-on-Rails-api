# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


6.times do
  User.create({
        nom:Faker::Name.name,
        email: Faker::Internet.email,
      })
end


10.times do
  Message.create({
       content:Faker::Lorem.sentence,
       actif: Faker::Number.between(from: 0, to: 1),
       status: Faker::Number.between(from: 1, to: 2),
       transmitter_id: Faker::Number.between(from: 1, to: 3),
       receiver_id: Faker::Number.between(from: 4, to: 6),
   })
end

