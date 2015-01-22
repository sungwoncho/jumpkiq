require 'rails_helper'

RSpec.describe AddressesController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body, symbolize_names: true) }

  let(:user) { create(:user) }

  before :each do
    sign_in user
  end

  describe 'GET show' do
    context 'when not logged in' do
      before :each do
        sign_out user
        get :show, format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do

      let!(:address) { create(:address, user_id: user.id) }

      before :each do
        get :show, format: :json
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      it 'assigns the current user to @user' do
        expect(assigns(:user)).to eq user
      end

      it "assigns user's address to @address" do
        expect(assigns(:address)).to eq address
      end
    end
  end

  describe 'POST create' do
    context 'when not logged in' do
      before :each do
        sign_out user
        post :create, address: attributes_for(:address), format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do

      context 'with valid attributes' do

        it 'returns 200 status' do
          post :create, address: attributes_for(:address), format: :json
          expect(response.status).to eq 200
        end

        it 'creates an address record' do
          expect {
            post :create, address: attributes_for(:address), format: :json
          }.to change(Address, :count).by(1)
        end

        it 'sets the address to belong to user' do
          post :create, address: attributes_for(:address), format: :json
          expect(Address.last.user).to eq user
        end
      end

      context 'with invalid params' do

        before :each do
          post :create, address: attributes_for(:address, city: nil), format: :json
        end

        it 'returns 422 status' do
          expect(response.status).to eq 422
        end
      end
    end
  end

  describe 'PUT update' do

    let!(:address) { create(:address, user: user) }

    context 'when not logged in' do
      before :each do
        sign_out user
        put :update, address: attributes_for(:address, city: 'San Francisco'), format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      context 'with valid params' do
        before :each do
          put :update, address: attributes_for(:address, city: 'San Francisco'), format: :json
        end

        it 'returns 200 status' do
          expect(response.status).to eq 200
        end

        it "updates current user's address" do
          user.reload
          expect(user.address.city).to eq 'San Francisco'
        end
      end

      context 'with invalid params' do
        before :each do
          put :update, address: attributes_for(:address, city: nil), format: :json
        end

        it 'returns 422 status' do
          expect(response.status).to eq 422
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:address) { create(:address, user: user) }

    context 'when not logged in' do
      before :each do
        sign_out user
        delete :destroy, format: :json, id: address
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      context 'when user has kiqs with requested status' do
        before :each do
          create(:kiq, user: user, status: 'requested')
          delete :destroy, format: :json, id: address
        end

        it 'returns method not allowed status' do
          expect(response.status).to eq 405
        end
      end

      context 'when user has kiqs with sent status' do
        before :each do
          create(:kiq, user: user, status: 'sent')
          delete :destroy, format: :json, id: address
        end

        it 'returns method not allowed status' do
          expect(response.status).to eq 405
        end
      end

      context 'when user has no requested or sent kiqs' do
        it 'deletes the Address' do
          expect {
            delete :destroy, format: :json, id: address
          }.to change(Address, :count).by(-1)
        end

        it 'returns 204 status' do
          delete :destroy, format: :json, id: address
          expect(response.status).to eq 204
        end
      end
    end
  end


end
