require 'rails_helper'

RSpec.describe Stylist, :type => :model do
  it 'has a valid factory' do
    expect(build(:stylist)).to be_valid
  end

  describe 'association' do
    it { should have_many(:assignments).dependent(:destroy) }
    it { should have_many(:users) }
    it { should have_many(:kiqs) }
    it { should have_many(:requested_kiqs).conditions(status: 'requested') }
    it { should have_many(:sent_kiqs).conditions(status: 'sent') }
    it { should have_many(:completed_kiqs).conditions(status: 'completed') }
    it { should have_many(:cancelled_kiqs).conditions(status: 'cancelled') }
  end

  describe 'instance methods' do
    let(:stylist) { create(:stylist, firstname: 'Jane', lastname: 'Kim', email: 'jkim@example.com') }

    describe '#name' do
      specify { expect(stylist.name).to eq 'Jane Kim' }
    end

    describe '#mailboxer_email' do
      skip
      # specify { expect(stylist.mailboxer_email).to eq 'jkim@example.com' }
    end
  end
end
