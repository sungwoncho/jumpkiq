FactoryGirl.define do
  factory :stylist do
    email
    password "pass1234"
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
  end
end
