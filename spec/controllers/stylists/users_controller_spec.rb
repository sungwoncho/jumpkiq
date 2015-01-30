require 'rails_helper'

RSpec.describe Stylists::UsersController, :type => :controller do
  let(:stylist) { create(:stylist) }
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }

  before(:each) do
    user.stylist = stylist
    sign_in stylist
  end

  describe 'GET index' do
    context 'when not logged in' do
      before(:each) do
        sign_out stylist
        get :index
      end

      it 'requires stylist login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do
      before(:each) do
        get :index
      end

      it "assigns all of stylist's clients to @users" do
        expect(assigns(:users)).to match_array [user]
      end
    end
  end

  describe 'GET show' do
    context 'when not logged in' do
      before(:each) do
        sign_out stylist
        get :show, id: user
      end

      it 'requires stylist login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do
      context 'with valid params' do
        before(:each) do
          get :show, id: user
        end

        it 'assigns the requested user to @user' do
          expect(assigns(:user)).to eq user
        end
      end
    end
  end

end
