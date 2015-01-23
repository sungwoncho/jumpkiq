require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  let(:user) { create(:user) }
  let(:stylist) { create(:stylist) }

  before :each do
    sign_in user
  end

  describe 'GET index' do
    context 'when not logged in' do
      before :each do
        sign_out user
        get :index, format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      let!(:message_1) { create(:message, user: user) }
      let!(:message_2) { create(:message, user: user) }

      before :each do
        get :index, format: :json
      end

      it "assign all user's messages to @messages" do
        expect(assigns(:messages)).to match_array [message_1, message_2]
      end

      it "sets 'is_read' to true for all messages" do
        message_1.reload
        message_2.reload

        expect(message_1.is_read).to be true
        expect(message_2.is_read).to be true
      end
    end
  end

  describe 'POST create' do
    context 'when not logged in' do
      before :each do
        sign_out user
        post :create, message: attributes_for(:message), format: :json
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      context 'with valid params' do
        before :each do
          post :create, message: attributes_for(:message), format: :json
        end

        it 'creates a message' do
          expect {
            post :create, message: attributes_for(:message), format: :json
          }.to change(Message, :count).by(1)
        end

        it 'returns 200 status' do
          expect(response.status).to eq 200
        end
      end

      context 'with invalid params' do
        before :each do
          post :create, message: attributes_for(:message, body: nil), format: :json
        end

        it 'does not create a message' do
          expect {
            post :create, message: attributes_for(:message, body: nil), format: :json
          }.not_to change(Message, :count)
        end

        it 'returns 422 status' do
          expect(response.status).to eq 422
        end
      end
    end
  end
end
