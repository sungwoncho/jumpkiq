require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:stylist) }
  end

  describe 'class method' do

    let(:user) { create(:user) }

    describe '.assign' do
      before :each do
        create(:stylist)
      end

      it 'creates a new assignment record' do
        expect {
          Assignment.assign_stylist(user)
        }.to change(Assignment, :count).by(1)
      end

      it 'assigns the user to a stylist' do
        Assignment.assign_stylist(user)
        expect(user.stylist).not_to be nil
      end
    end
  end
end
