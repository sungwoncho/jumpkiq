require 'rails_helper'

RSpec.describe Address, :type => :model do
  it 'has a valid factory' do
    expect(build(:address)).to be_valid
  end

  describe 'association' do
    it { should belong_to(:user) }
  end

  describe 'validation' do
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:postcode) }
  end

  describe 'instance methods' do
    describe '#full_address' do
      it 'combines the address columns' do
        address = create(:address, street_address: '100 Happy Street', secondary_address: 'Apt. 100A', city: 'Sydney', state: 'NSW', postcode: 2000)
        expect(address.full_address).to eq '100 Happy Street, Apt. 100A, Sydney, NSW, 2000'
      end
    end
  end
end
