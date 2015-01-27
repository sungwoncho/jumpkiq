class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mailbox
  before_action :set_conversation, only: :show

  def index
    @conversations = @mailbox.conversations
    render nothing: true
  end

  def show
    @receipts = @mailbox.receipts_for(@conversation).not_trash
    # @receipts.mark_as_read
    render nothing: true
  end

  private
    def set_mailbox
      @mailbox = current_user.mailbox
    end

    def set_conversation
      @conversation = @mailbox.conversations.find(params[:id])
    end
end
