class UsersController < ApplicationController
  def show
    head 404 unless user_signed_in?

    @user = current_user
  end
end
