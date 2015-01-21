require 'rails_helper'

RSpec.describe Item, :type => :model do
  it 'has a valid factory' do
    expect(build(:item)).to be_valid
  end

  describe 'association' do
    it { should have_one(:kiq_item) }
    it { should have_one(:kiq).through(:kiq_item) }
  end

  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:kind) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:purchased_value) }
  end
end
