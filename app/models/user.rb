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
  has_many :sent_kiqs, -> { where status: 'sent' }, class_name: 'Kiq'
  has_many :completed_kiqs, -> { where status: 'completed' }, class_name: 'Kiq'
  has_many :cancelled_kiqs, -> { where status: 'cancelled' }, class_name: 'Kiq'
  has_many :sent_messages, as: :sender, class_name: 'Message'
  has_many :received_messages, as: :receiver, class_name: 'Message'

  validates_presence_of :height
  validates_presence_of :weight
  validates_presence_of :casual_shirt_size

  def update_stripe_customer_id(customer_id)
    update(stripe_customer_id: customer_id)
  end

  def has_shipping_address?
    address.present?
  end

  def has_credit_card?
    stripe_customer_id.present?
  end

  def has_style?
    smart_style || casual_style || hipster_style || classic_style
  end

  def has_need?
    long_sleeve || short_sleeve || polo_shirt || pants || shorts
  end

  def ready_to_order?
    has_shipping_address? && has_credit_card? && has_style? && has_need? && requested_kiqs.empty?
  end

  def messages
    messages = received_messages + sent_messages
    messages.sort_by(&:created_at)
  end

  protected
    def assign_stylist
      Assignment.assign_stylist(self)
    end
end
