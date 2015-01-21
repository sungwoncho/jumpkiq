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
    it { should have_many(:pending_kiqs).conditions(status: 'pending') }
    it { should have_many(:completed_kiqs).conditions(status: 'completed') }
    it { should have_many(:cancelled_kiqs).conditions(status: 'cancelled') }
  end
end
