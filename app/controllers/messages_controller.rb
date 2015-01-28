class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @receipt = current_user.send_message(current_user.stylist, params[:body], params[:subject])
    if @receipt.errors.blank? && @receipt.valid?
      render nothing: true, status: 201
    end
  end
end
