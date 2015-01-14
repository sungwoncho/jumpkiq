require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'association' do
    it { should have_one(:assignment) }
    it { should have_one(:stylist) }
  end
end
