module API
  class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_mailbox
    before_action :set_conversation, except: :index

    def index
      @conversations = @mailbox.conversations
    end

    def show
      @receipts = @mailbox.receipts_for(@conversation).not_trash
      # There is an unresolved issue in Mailboxer gem for mark_as_read
      # @receipts.mark_as_read

      @messages = @receipts.map { |receipt| receipt.message }
    end

    def update
      if params[:reply].present?
        last_receipt = @mailbox.receipts_for(@conversation).last
        @receipt = current_user.reply_to_all(last_receipt, params[:body])
        @messages = [@receipt.message]
        render :show, status: 200
      end
    end

    private
      def set_mailbox
        @mailbox = current_user.mailbox
      end

      def set_conversation
        @conversation = @mailbox.conversations.find(params[:id])
      end
  end
end
