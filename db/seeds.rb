# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

User.destroy_all
Stylist.destroy_all

(1..10).each do |n|
  Stylist.create!(
  firstname: Faker::Name.first_name,
  lastname: Faker::Name.last_name,
  email: "stylist_#{n}@example.com",
  password: "pass1234",
  password_confirmation: "pass1234",
  )
end

puts "Created #{Stylist.count} stylists"


User.create!(
  firstname: Faker::Name.first_name,
  lastname: Faker::Name.last_name,
  email: "test@test.com",
  password: "pass1234",
  password_confirmation: "pass1234",
  height: 175,
  weight: 72,
  casual_shirt_size: 'M'
)

(1..10).each do |n|
  User.create!(
  firstname: Faker::Name.first_name,
  lastname: Faker::Name.last_name,
  email: "test_#{n}@example.com",
  password: "pass1234",
  password_confirmation: "pass1234",
  height: 175,
  weight: 72,
  casual_shirt_size: 'M'
  )
end

puts "Created #{User.count} users."
