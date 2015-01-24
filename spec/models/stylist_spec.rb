require 'rails_helper'

RSpec.describe Stylist, :type => :model do

  let(:user) { create(:user) }
  let(:stylist) { create(:stylist) }

  it 'has a valid factory' do
    expect(build(:stylist)).to be_valid
  end

  describe 'association' do
    it { should have_many(:assignments).dependent(:destroy) }
    it { should have_many(:users) }
    it { should have_many(:kiqs) }
    it { should have_many(:requested_kiqs).conditions(status: 'requested') }
    it { should have_many(:pending_kiqs).conditions(status: 'pending') }
    it { should have_many(:completed_kiqs).conditions(status: 'completed') }
    it { should have_many(:cancelled_kiqs).conditions(status: 'cancelled') }
    it { should have_many(:sent_messages) }
    it { should have_many(:received_messages) }
  end

  describe 'instance methods' do
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
