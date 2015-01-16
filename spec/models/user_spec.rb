require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'association' do
    it { should have_one(:assignment).dependent(:destroy) }
    it { should have_one(:stylist) }
    it { should have_one(:address).dependent(:destroy) }
  end

  describe 'validation' do
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:casual_shirt_size) }
  end

  let(:user) { create(:user) }
  let!(:stylist) { create(:stylist) }

  describe 'callbacks' do
    context 'after creation' do
      it 'assigns a stylist' do
        expect(user.stylist).not_to eq nil
      end
    end
  end

  describe 'instance_methods' do
    describe '#update_stripe_customer_id' do
      it 'updates the stripe_customer_id' do
        user.update_stripe_customer_id('1234Stripe')
        expect(user.stripe_customer_id).to eq '1234Stripe'
      end
    end
  end
end
