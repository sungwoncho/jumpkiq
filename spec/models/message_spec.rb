require 'rails_helper'

RSpec.describe Message, :type => :model do
  it 'has a valid factory' do
    expect(build(:message)).to be_valid
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:stylist) }
  end

  describe 'validation' do
    it { should validate_presence_of(:body) }
  end
end
