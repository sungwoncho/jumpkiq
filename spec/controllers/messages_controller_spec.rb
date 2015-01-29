require 'rails_helper'

RSpec.describe API::MessagesController, :type => :controller do
  let(:jane) { create(:stylist, firstname: 'Jane') }
  let(:alex) { create(:user, lastname: 'Alex') }

  before :each do
    alex.stylist = jane

    jane.send_message(alex, 'hello', 'how are you')
    alex.send_message(jane, 'blue sky', 'deep ocean')
    @conversation_1 = Mailboxer::Conversation.first
    @conversation_2 = Mailboxer::Conversation.second

    sign_in alex
  end

  describe 'POST create' do
    context 'when not logged in' do
      before :each do
        sign_out alex
        post :create, format: :json, subject: 'whatup', body: 'hi'
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      it 'sends the message to the stylist' do
        expect {
          post :create, format: :json, subject: 'whatup', body: 'hi'
        }.to change{ jane.mailbox.conversations.count }.by(1)
      end

      # it 'returns 201 status' do
      #   expect(response.status).to eq 201
      # end
    end
  end
end
