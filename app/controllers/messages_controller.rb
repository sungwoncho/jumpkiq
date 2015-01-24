class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_messages, only: :index

  def index
    mark_all_as_read(@messages)
  end

  def create
    @message = current_user.sent_messages.new(message_params)
    @message.receiver = current_user.stylist

    if @message.save
      render nothing: true, status: 200
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private
    def set_messages
      @messages = current_user.messages
    end

    def mark_all_as_read(messages)
      current_user.received_messages.each { |m| m.update(is_read: true) }
    end

    def message_params
      params.require(:message).permit(:body)
    end
end
