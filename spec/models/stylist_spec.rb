require 'rails_helper'

RSpec.describe Stylist, :type => :model do
  describe 'association' do
    it { should have_many(:assignments) }
    it { should have_many(:users) }
  end
end
