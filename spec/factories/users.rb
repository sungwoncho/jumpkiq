FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email
    password "pass1234"
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    smart_kiq true
    casual_kiq true
    hipster_kiq false
    classic_kiq false
  end
end
