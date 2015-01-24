require 'rails_helper'

RSpec.describe Message, :type => :model do
  it 'has a valid factory' do
    expect(build(:message)).to be_valid
  end

  describe 'association' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end

  describe 'validation' do
    it { should validate_presence_of(:body) }
  end
end
