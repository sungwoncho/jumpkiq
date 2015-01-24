require 'rails_helper'

RSpec.describe Stylists::MessagesController, :type => :controller do
  let(:stylist) { create(:stylist) }
  let(:user) { create(:user) }

  before :each do
    user.stylist = stylist
    sign_in stylist
  end

  describe 'GET index' do
    context 'when not logged in' do
      before :each do
        sign_out stylist
        get :index, id: user
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      let!(:message_1) { create(:message, sender: user, receiver: stylist) }
      let!(:message_2) { create(:message, sender: user, receiver: stylist) }
      let!(:message_3) { create(:message, sender: stylist, receiver: user) }

      before :each do
        get :index, id: user
      end

      it "assigns stylist's all messages to @messages" do
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
        sign_out stylist
        post :create, id: user, message: attributes_for(:message)
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do
      context 'with valid params' do
        before :each do
          request.env["HTTP_REFERER"] = stylists_messages_url(user) unless request.nil? || request.env.nil? # to test redirect_to :back
          post :create, id: user, message: attributes_for(:message)
        end

        it 'assigns the requested user to @user' do
          expect(assigns(:user)).to eq user
        end

        it 'creates a message' do
          expect {
            post :create, id: user, message: attributes_for(:message)
          }.to change(Message, :count).by(1)
        end

        it 'sets current stylist as the sender' do
          expect(Message.last.sender).to eq stylist
        end

        it "sets the requested user as the receiver" do
          expect(Message.last.receiver).to eq user
        end
      end
    end
  end
end
