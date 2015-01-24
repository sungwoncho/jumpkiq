class Stylists::PagesController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_stylist
  before_action :set_kiq_count
  before_action :set_user_count

  def dashboard
  end

  protected

    def set_stylist
      @stylist = current_stylist.decorate
    end

    def set_kiq_count
      @kiq_count = current_stylist.kiqs.count
    end

    def set_user_count
      @user_count = current_stylist.users.count
    end
end
