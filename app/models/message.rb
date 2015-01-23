class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :stylist

  validates_presence_of :body
end
