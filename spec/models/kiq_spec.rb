require 'rails_helper'

RSpec.describe Kiq, :type => :model do
  it 'has a valid factory' do
    expect(build(:kiq)).to be_valid
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:stylist) }
    it { should have_many(:kiq_items) }
    it { should have_many(:items).through(:kiq_items) }
  end
end
