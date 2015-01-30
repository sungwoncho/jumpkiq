require 'rails_helper'

RSpec.describe Stylists::PagesController, :type => :controller do
  let(:stylist) { create(:stylist) }
  let(:user) { create(:user) }

  before :each do
    sign_in stylist
  end

  describe 'GET dashboard' do

    context 'when not logged in' do
      before :each do
        sign_out stylist
        get :dashboard
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      let!(:kiq) { create(:kiq, stylist: stylist) }

      before :each do
        stylist.send_message(user, 'hi', 'how are you?')
        get :dashboard
      end

      it 'assigns kiq count to @kiq_count' do
        expect(assigns(:kiq_count)).to eq 1
      end

      it 'assigns conversation count to @conversation_count' do
        expect(assigns(:conversation_count)).to eq 1
      end

      it 'assigns current stylist to @stylist' do
        expect(assigns(:stylist)).to eq stylist
      end

      it 'decorates the @stylist' do
        expect(assigns(:stylist)).to be_decorated
      end
    end
  end
end
