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

      let!(:kiq) { create(:kiq, stylist: stylist, status: 'requested') }

      before :each do
        stylist.send_message(user, 'hi', 'how are you?')
        get :dashboard
      end

      it 'assigns all kiqs to @kiqs' do
        expect(assigns(:kiqs)).to match_array [kiq]
      end

      it 'assigns all requested kiqs to @requestedkiqs' do
        expect(assigns(:requested_kiqs)).to eq [kiq]
      end

      it 'assigns conversation count to @conversation_count' do
        expect(assigns(:conversation_count)).to eq 1
      end

      it 'assigns client count to @client_count' do
        stylist.users = []
        stylist.users << user # necessary because send_message changes the stylist.users.count
        get :dashboard
        expect(assigns(:client_count)).to eq 1
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
