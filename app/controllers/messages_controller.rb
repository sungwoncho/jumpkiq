class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @receipt = current_user.send_message(current_user.stylist, params[:body], params[:subject])
    render nothing: true
  end
end
