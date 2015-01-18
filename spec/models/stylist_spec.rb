require 'rails_helper'

RSpec.describe Stylist, :type => :model do
  it 'has a valid factory' do
    expect(build(:stylist)).to be_valid
  end

  describe 'association' do
    it { should have_many(:assignments).dependent(:destroy) }
    it { should have_many(:users) }
    it { should have_many(:kiqs) }
  end
end
