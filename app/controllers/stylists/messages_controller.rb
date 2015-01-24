class Stylists::MessagesController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_messages
  before_action :set_user

  def index
    mark_all_as_read(@messages)
  end

  def create
    @message = current_stylist.sent_messages.new(message_params)
    @message.receiver = @user

    if @message.save
      redirect_to :back
    else
      redirect_to :back, notice: 'An error occurred.'
    end
  end

  private
    def mark_all_as_read(messages)
      current_stylist.received_messages.each { |m| m.update(is_read: true) }
    end

    def set_messages
      @messages = current_stylist.messages
    end

    def set_user
      @user = current_stylist.users.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
