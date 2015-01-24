FactoryGirl.define do
  factory :message do
    association :sender, factory: :user
    association :receiver, factory: :stylist
    body { Faker::Lorem.sentence }
    is_read false
  end
end
