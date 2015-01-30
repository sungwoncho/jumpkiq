class Stylists::ConversationsController < ApplicationController
  before_action :authenticate_stylist!
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
      @receipt = current_stylist.reply_to_all(last_receipt, params[:body])
      @messages = [@receipt.message]
      redirect_to action: :show
    end
  end

  private
  def set_mailbox
    @mailbox = current_stylist.mailbox
  end

  def set_conversation
    @conversation = @mailbox.conversations.find(params[:id])
  end
end
