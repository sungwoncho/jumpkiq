require 'rails_helper'

RSpec.describe API::ConversationsController, :type => :controller do
  let(:jane) { create(:user, firstname: 'Jane') }
  let(:alex) { create(:user, lastname: 'Alex') }

  before :each do
    jane.send_message(alex, 'hello', 'how are you')
    alex.send_message(jane, 'blue sky', 'deep ocean')
    @conversation_1 = Mailboxer::Conversation.first
    @conversation_2 = Mailboxer::Conversation.second

    sign_in alex
  end

  describe 'GET index' do
    context 'when not logged in' do
      before :each do
        sign_out alex
        get :index, format: :json
      end

      it 'returns 401' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      before :each do
        get :index, format: :json
      end

      it 'assigns the conversations in the inbox to @conversations' do
        expect(assigns(:conversations)).to match_array [@conversation_1, @conversation_2]
      end
    end
  end

  describe 'GET show' do
    context 'when not logged in' do
      before :each do
        sign_out alex
        get :show, format: :json, id: @conversation_1
      end
      it 'returns 401' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      before :each do
        @conversation_receipt = alex.mailbox.receipts_for(@conversation_1).not_trash
        get :show, format: :json, id: @conversation_1
      end

      it 'assigns the requested conversation to @conversation' do
        expect(assigns(:conversation)).to eq @conversation_1
      end

      it 'assigns the receipts of the conversation to @receipt' do
        expect(assigns(:receipts)).to eq @conversation_receipt
      end

      # it 'marks the receipts as read' do
      #   @conversation_receipt.reload
      #   p @conversation_receipt
      #   expect(@conversation_receipt.is_read).to be true
      # end
    end
  end

  describe 'PUT update' do
    context 'when not logged in' do
      before :each do
        sign_out alex
        put :update, format: :json, id: @conversation_1
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do
      context 'with param[:reply]' do
        before :each do
          put :update, format: :json, id: @conversation_1, reply: true, body: 'doing good'
        end

        it 'creates a message for the conversation' do
          expect(@conversation_1.messages.count).to eq 2
        end

        it 'sends the message from the user' do
          expect(@conversation_1.messages.last.sender).to eq alex
        end

        it 'sends the message to stylist' do
          expect(jane.mailbox.conversations.first.messages.count).to eq 2
        end

        it 'returns 200 status' do
          expect(response.status).to eq 200
        end
      end
    end
  end


end
