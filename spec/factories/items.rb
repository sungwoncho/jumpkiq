FactoryGirl.define do
  factory :item do
    name 'Flannel shirt'
    brand 'Zara'
    kind 'long sleeve'
    status 'available'
    value 60
    purchased_value 40
    smart false
    casual true
    hipster false
    classic false
  end
end
