class User < ActiveRecord::Base
  after_create :assign_stylist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :assignment, dependent: :destroy
  has_one :stylist, through: :assignment
  has_one :address, dependent: :destroy
  has_many :kiqs
  has_many :requested_kiqs, -> { where status: 'requested' }, class_name: 'Kiq'
  has_many :pending_kiqs, -> { where status: 'pending' }, class_name: 'Kiq'
  has_many :completed_kiqs, -> { where status: 'completed' }, class_name: 'Kiq'

  validates_presence_of :height
  validates_presence_of :weight
  validates_presence_of :casual_shirt_size

  def update_stripe_customer_id(customer_id)
    update(stripe_customer_id: customer_id)
  end

  protected
    def assign_stylist
      Assignment.assign_stylist(self)
    end
end
