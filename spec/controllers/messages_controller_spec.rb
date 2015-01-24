require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  let(:stylist) { create(:stylist) }
  let(:user) { create(:user, stylist: stylist) }

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
      let!(:message_1) { create(:message, sender: stylist, receiver: user) }
      let!(:message_2) { create(:message, sender: stylist, receiver: user) }
      let!(:message_3) { create(:message, sender: user, receiver: stylist) }

      before :each do
        get :index, format: :json
      end

      it "assign all user's messages to @messages" do
        expect(assigns(:messages)).to match_array [message_1, message_2, message_3]
      end

      it "sets 'is_read' to true for all received messages" do
        message_1.reload
        message_2.reload
        message_3.reload

        expect(message_1.is_read).to be true
        expect(message_2.is_read).to be true
        expect(message_3.is_read).to be false
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

        it 'sets current user as the sender' do
          expect(Message.last.sender).to eq user
        end

        it "sets the user's stylist as the receiver" do
          expect(Message.last.receiver).to eq stylist
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
