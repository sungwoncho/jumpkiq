FactoryGirl.define do
  factory :address do
    street_address { Faker::Address.street_address }
    secondary_address { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state ['NSW', 'ACT', 'NT', 'WA', 'SA'].sample
    postcode 2000
    association :user, factory: :user
  end
end
