class User < ActiveRecord::Base
  after_create :assign_stylist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :assignment, dependent: :destroy
  has_one :stylist, through: :assignment

  validates_presence_of :height
  validates_presence_of :weight
  validates_presence_of :casual_shirt_size

  protected
    def assign_stylist
      Assignment.assign_stylist(self)
    end
end
