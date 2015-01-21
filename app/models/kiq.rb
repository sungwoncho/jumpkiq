class Kiq < ActiveRecord::Base
  belongs_to :user
  belongs_to :stylist
  has_many :kiq_items
  has_many :items, through: :kiq_items
end
