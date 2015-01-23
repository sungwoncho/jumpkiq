FactoryGirl.define do
  factory :message do
    association :user, factory: :user
    association :stylist, factory: :stylist
    body { Faker::Lorem.sentence }
    is_read false
  end
end
