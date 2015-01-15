class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of(:street_address)
  validates_presence_of(:city)
  validates_presence_of(:state)
  validates_presence_of(:postcode)

  def full_address
    "#{street_address}, #{secondary_address}, #{city}, #{state}, #{postcode}"
  end
end
