# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 10.times do
#   name = Faker::Name.first_name
#   User.create(email: Faker::Internet.safe_email(name), first_name: name, last_name: Faker::Name.last_name, password: "password")
# end
#
# 100.times do
#   Event.create(name: Faker::Hipster.sentence(3), description: Faker::Hipster.paragraph, created_by: rand(1..10))
# end

1000.times do
  random_user = User.order("RAND()").first.id
  random_event = Event.order("RAND()").first.id
  Attending.create(event_id: random_event, user_id: random_user)
end
