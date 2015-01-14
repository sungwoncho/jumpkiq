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

      it 'returns 404 status' do
        expect(response.status).to eq 404
      end
    end
  end
end
