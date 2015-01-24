class Stylist < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments
  has_many :kiqs
  has_many :requested_kiqs, -> { where status: 'requested' }, class_name: 'Kiq'
  has_many :pending_kiqs, -> { where status: 'pending' }, class_name: 'Kiq'
  has_many :completed_kiqs, -> { where status: 'completed' }, class_name: 'Kiq'
  has_many :cancelled_kiqs, -> { where status: 'cancelled' }, class_name: 'Kiq'
  has_many :sent_messages, as: :sender, class_name: 'Message'
  has_many :received_messages, as: :receiver, class_name: 'Message'

  def messages
    messages = received_messages + sent_messages
    messages.sort_by(&:created_at)
  end
end
