require 'rails_helper'

RSpec.describe Stylists::UsersController, :type => :controller do
  let(:stylist) { create(:stylist) }
  let(:stylist_2) { create(:stylist) }
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:user_3) { create(:user) }

  before :each do
    user_1.stylist = stylist
    user_2.stylist = stylist
    user_3.stylist = stylist_2

    sign_in stylist
  end

  describe 'GET index' do
    context 'when not logged in' do
      before :each do
        sign_out stylist
        get :index
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      before :each do
        get :index
      end

      it "assigns all stylist's users to @user" do
        expect(assigns(:users)).to match_array [user_1, user_2]
      end
    end
  end

  describe 'GET show' do
    context 'when not logged in' do
      before :each do
        sign_out stylist
        get :show, id: user_1
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do
      context 'when requested user is assigned to stylist' do
        before :each do
          get :show, id: user_1
        end

        it 'assigns the requested user to @user' do
          expect(assigns(:user)).to eq user_1
        end
      end

      context 'when requested user is not assigned to stylist' do
        it 'assigns the reqeusted user to @user' do
          expect {
            get :show, id: user_3
          }.to raise_error
        end
      end
    end
  end

end
