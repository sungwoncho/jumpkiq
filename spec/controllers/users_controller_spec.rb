require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body, symbolize_names: true) }

  let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  describe 'GET show' do
    context 'when logged in' do
      before :each do
        get :show, format: :json
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'assigns the current user to @user' do
        expect(assigns(:user)).to eq user
      end
    end

    context 'when not logged in' do
      before :each do
        sign_out user
        get :show, format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end
  end

  describe 'PUT update' do
    context 'when not logged in' do
      before :each do
        sign_out user
        put :update, format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do

      context 'with valid params' do

        before :each do
          put :update, user: attributes_for(:user, classic_style: true), format: :json
          user.reload
        end

        it 'assigns the current user to @user' do
          expect(assigns(:user)).to eq user
        end

        it 'updates the user' do
          expect(user.classic_style).to eq true
        end

        it 'returns 200 status' do
          expect(response.status).to eq 200
        end

      end


      context 'with invalid params' do

        before :each do
          put :update, user: attributes_for(:user, height: nil), format: :json
          user.reload
        end

        it 'returns 422 status' do
          expect(response.status).to eq 422
        end
      end
    end
  end
end
