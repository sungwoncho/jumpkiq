class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :stylist

  def self.assign_stylist(user)
    user.stylist = Stylist.first
  end
end
