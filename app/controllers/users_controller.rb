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
      :long_sleeve_max_budget, :short_sleeve_max_budget, :polo_shirt_max_budget, :pants_max_budget, :shorts_max_budget,
      :smart_style, :casual_style, :hipster_style, :classic_style)
    end
end
