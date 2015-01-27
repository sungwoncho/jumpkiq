class Stylist < ActiveRecord::Base
  acts_as_messageable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments
  has_many :kiqs
  has_many :requested_kiqs, -> { where status: 'requested' }, class_name: 'Kiq'
  has_many :sent_kiqs, -> { where status: 'sent' }, class_name: 'Kiq'
  has_many :completed_kiqs, -> { where status: 'completed' }, class_name: 'Kiq'
  has_many :cancelled_kiqs, -> { where status: 'cancelled' }, class_name: 'Kiq'

  def name
    "#{firstname} #{lastname}"
  end

  def mailboxer_email(object)
    email
  end
end
