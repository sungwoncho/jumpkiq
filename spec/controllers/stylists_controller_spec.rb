require 'rails_helper'

RSpec.describe StylistsController, :type => :controller do
  let(:stylist) { create(:stylist) }

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
        get :dashboard
      end

      it 'assigns all the kiqs to @kiqs' do
        expect(assigns(:kiqs)).to eq [kiq]
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
