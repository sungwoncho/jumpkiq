class Item < ActiveRecord::Base
  has_one :kiq_item
  has_one :kiq, through: :kiq_item

  validates_presence_of :name
  validates_presence_of :brand
  validates_presence_of :kind
  validates_presence_of :value
  validates_presence_of :purchased_value
end
