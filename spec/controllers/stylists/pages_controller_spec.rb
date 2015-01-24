require 'rails_helper'

RSpec.describe Stylists::PagesController, :type => :controller do
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

      let!(:user_1) { create(:user) }
      let!(:user_2) { create(:user) }
      let!(:kiq) { create(:kiq, user: user_1, stylist: stylist) }

      before :each do
        user_1.stylist = stylist
        user_2.stylist = stylist
        get :dashboard
      end

      it 'assigns the kiq counts to @kiq_count' do
        expect(assigns(:kiq_count)).to eq 1
      end

      it 'assigns the user counts to @user_count' do
        expect(assigns(:user_count)).to eq 2
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
