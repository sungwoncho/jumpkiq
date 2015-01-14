require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:stylist) }
  end
end
