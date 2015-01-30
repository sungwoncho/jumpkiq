require 'rails_helper'

RSpec.describe Stylists::ConversationsController, :type => :controller do
  let(:jane) { create(:stylist, firstname: 'Jane') }
  let(:alex) { create(:user, lastname: 'Alex') }

  before :each do
    jane.send_message(alex, 'hello', 'how are you')
    alex.send_message(jane, 'blue sky', 'deep ocean')
    @conversation_1 = Mailboxer::Conversation.first
    @conversation_2 = Mailboxer::Conversation.second

    sign_in jane
  end

  describe 'GET index' do
    context 'when not logged in' do
      before :each do
        sign_out jane
        get :index
      end

      it 'requires login' do
        expect(response.status).to require_stylist_login
      end
    end

    context 'when logged in' do
      before :each do
        get :index
      end

      it 'assigns the conversations in the inbox to @conversations' do
        expect(assigns(:conversations)).to match_array [@conversation_1, @conversation_2]
      end
    end
  end

  describe 'GET show' do
    context 'when not logged in' do
      before :each do
        sign_out jane
        get :show, id: @conversation_1
      end

      it 'requires login' do
        expect(response.status).to require_stylist_login
      end
    end

    context 'when logged in' do
      before :each do
        @conversation_receipt = jane.mailbox.receipts_for(@conversation_2).not_trash
        get :show, id: @conversation_2
      end

      it 'assigns the requested conversation to @conversation' do
        expect(assigns(:conversation)).to eq @conversation_2
      end

      it 'assigns the receipts of the conversation to @receipt' do
        expect(assigns(:receipts)).to eq @conversation_receipt
      end

      it 'marks the receipts as read' do
        skip('an issue in Mailboxer gem with PG')
        # @conversation_receipt.reload
        # p @conversation_receipt
        # expect(@conversation_receipt.is_read).to be true
      end
    end
  end

  describe 'PUT update' do
    context 'when not logged in' do
      before :each do
        sign_out jane
        put :update, id: @conversation_2
      end

      it 'requires login' do
        expect(response.status).to require_stylist_login
      end
    end

    context 'when logged in' do
      context 'with param[:reply]' do
        before :each do
          put :update, id: @conversation_2, reply: true, body: 'doing good'
        end

        it 'creates a message for the conversation' do
          expect(@conversation_2.messages.count).to eq 2
        end

        it 'sends the message from the stylist' do
          expect(@conversation_2.messages.last.sender).to eq jane
        end

        it 'sends the message to user' do
          expect(alex.mailbox.conversations.first.messages.count).to eq 2
        end

        it 'redirects to show' do
          expect(response).to redirect_to action: :show
        end
      end
    end
  end

end
