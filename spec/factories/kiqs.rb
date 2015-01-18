FactoryGirl.define do
  factory :kiq do
    association :user, factory: :user
    association :stylist, factory: :stylist
    status 'requested'
  end
end
