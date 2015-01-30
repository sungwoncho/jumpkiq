class Stylists::MessagesController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_user

  def new
  end

  def create
    @receipt = current_stylist.send_message(@user, params[:body], params[:subject])
    if @receipt.errors.blank? && @receipt.valid?
      @conversation = @receipt.conversation
      redirect_to stylists_conversation_url(@conversation), success: 'Message sent.'
    end
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
