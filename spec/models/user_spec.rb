require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'association' do
    it { should have_one(:assignment).dependent(:destroy) }
    it { should have_one(:stylist) }
  end

  let!(:stylist) { create(:stylist) }

  describe 'callbacks' do
    context 'after creation' do
      it 'assigns a stylist' do
        user = create(:user)
        expect(user.stylist).not_to eq nil
      end
    end
  end
end
