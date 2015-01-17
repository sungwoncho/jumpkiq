class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  protected

    def set_user
      @user = current_user
    end


  private

    def user_params
      params.require(:user).permit(:firstname, :lastname,
      :height, :weight, :casual_shirt_size,
      :long_sleeve, :short_sleeve, :polo_shirt, :pants, :shorts,
      :smart_style, :casual_style, :hipster_style, :classic_style)
    end
end
