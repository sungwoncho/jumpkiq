require 'rails_helper'

RSpec.describe KiqItem, :type => :model do
  describe 'association' do
    it { should belong_to(:kiq) }
    it { should belong_to(:item) }
  end
end
