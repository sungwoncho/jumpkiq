require 'rails_helper'

RSpec.describe Stylists::MessagesController, :type => :controller do
  let(:jane) { create(:stylist, firstname: 'Jane') }
  let(:alex) { create(:user, lastname: 'Alex') }

  before :each do
    alex.stylist = jane
    sign_in jane
  end

  describe 'POST create' do
    context 'when not logged in' do
      before :each do
        sign_out jane
        post :create, subject: 'whatup', body: 'hi'
      end

      it 'requires stylist login' do
        expect(response.status).to require_stylist_login
      end
    end

    context 'when logged in' do
      it 'assigns the requested user to @user' do
        post :create, format: :json, id: alex.id, subject: 'whatup', body: 'hi'
        expect(assigns(:user)).to eq alex
      end

      it 'sends the message to the user' do
        expect {
          post :create, format: :json, id: alex.id, subject: 'whatup', body: 'hi'
        }.to change{ alex.mailbox.conversations.count }.by(1)
      end

      it 'redirects to the conversation created' do
        post :create, format: :json, id: alex.id, subject: 'whatup', body: 'hi'
        expect(response).to redirect_to stylists_conversation_url(Mailboxer::Conversation.last)
      end
    end
  end
end
