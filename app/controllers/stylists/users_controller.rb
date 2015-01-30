class Stylists::UsersController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_users, only: :index
  before_action :set_user, only: :show

  def index
  end

  def show
  end

  private
    def set_users
      @users = current_stylist.users.paginate(page: params[:page], per_page: 10)
    end

    def set_user
      @user = current_stylist.users.find(params[:id])
    end
end
