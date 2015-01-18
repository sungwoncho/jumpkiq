FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email
    password "pass1234"
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    smart_style false
    casual_style false
    hipster_style false
    classic_style false

    long_sleeve false
    short_sleeve false
    polo_shirt false
    pants false
    shorts false

    height 175
    weight 75
    casual_shirt_size 'M'
  end
end
