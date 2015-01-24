require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { create(:user) }
  let!(:stylist) { create(:stylist) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'association' do
    it { should have_one(:assignment).dependent(:destroy) }
    it { should have_one(:stylist) }
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:kiqs) }
    it { should have_many(:requested_kiqs).conditions(status: 'requested') }
    it { should have_many(:sent_kiqs).conditions(status: 'sent') }
    it { should have_many(:completed_kiqs).conditions(status: 'completed') }
    it { should have_many(:cancelled_kiqs).conditions(status: 'cancelled') }
    it { should have_many(:sent_messages) }
    it { should have_many(:received_messages) }
  end

  describe 'validation' do
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:casual_shirt_size) }
  end



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

    describe '#has_style?' do
      context 'when user has specified at least one style preferences' do
        before :each do
          user.update(smart_style: true)
        end

        specify { expect(user.has_style?).to be true }
      end

      context 'when user has not specified any style preferences' do
        specify { expect(user.has_style?).to be false }
      end
    end

    describe '#has_need?' do
      context 'when user has specified needs' do
        before :each do
          user.update(polo_shirt: true)
        end

        specify { expect(user.has_need?).to be true }
      end

      context 'when user has not specified needs' do
        specify { expect(user.has_need?).to be false }
      end
    end

    describe '#ready_to_order?' do
      context "when user has a kiq with 'requested' status" do
        before :each do
          create(:kiq, user: user, status: 'requested')
        end

        specify { expect(user).not_to be_ready_to_order }
      end
    end

    describe '#messages' do
      let!(:message_1) { create(:message, sender: user, receiver: stylist, created_at: 3.days.ago, updated_at: 3.days.ago) }
      let!(:message_2) { create(:message, sender: stylist, receiver: user) }

      it 'combines and returns sent_messages and received_messages' do
        expect(user.messages).to match_array [message_1, message_2]
      end

      it 'orders the messages by created_at' do
        expect(user.messages).to eq [message_1, message_2]
      end
    end
  end
end
