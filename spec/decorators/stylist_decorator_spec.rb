require 'rails_helper'

describe StylistDecorator, type: :decorator do

  describe 'full_name' do
    it 'returns the full name' do
      stylist = create(:stylist, firstname: 'Johanna', lastname: 'Kane').decorate
      expect(stylist.full_name).to eq 'Johanna Kane'
    end
  end
end
