require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'association' do
    it { should have_one(:assignment).dependent(:destroy) }
    it { should have_one(:stylist) }
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:kiqs) }
    it { should have_many(:requested_kiqs).conditions(status: 'requested') }
    it { should have_many(:pending_kiqs).conditions(status: 'pending') }
    it { should have_many(:completed_kiqs).conditions(status: 'completed') }
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

    describe '#has_shipping_address?' do
      context 'when user has a shipping address' do
        before :each do
          create(:address, user: user)
        end

        specify { expect(user.has_shipping_address?).to be true }
      end

      context 'when user does not have a shipping address' do
        specify { expect(user.has_shipping_address?).to be false }
      end
    end

    describe '#has_credit_card?' do
      context 'when user has a stripe_customer_id' do
        before :each do
          user.stripe_customer_id = 'sample_id'
        end

        specify { expect(user.has_credit_card?).to be true }
      end

      context 'when user does not have stripe_customer_id' do
        specify { expect(user.has_credit_card?).to be false }
      end
    end

    describe '#has_styles?' do
      context 'when user has specified at least one style preferences' do
        before :each do
          user.update(smart_style: true)
        end

        specify { expect(user.has_styles?).to be true }
      end

      context 'when user has not specified any style preferences' do
        specify { expect(user.has_styles?).to be false }
      end
    end

    describe '#has_needs?' do
      context 'when user has specified needs' do
        before :each do
          user.update(polo_shirt: true)
        end

        specify { expect(user.has_needs?).to be true }
      end

      context 'when user has not specified needs' do
        specify { expect(user.has_needs?).to be false }
      end
    end
  end
end
