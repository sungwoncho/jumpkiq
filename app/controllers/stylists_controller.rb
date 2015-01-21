class StylistsController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_stylist
  before_action :set_kiqs

  def dashboard
  end

  protected

    def set_stylist
      @stylist = current_stylist.decorate
    end

    def set_kiqs
      @kiqs = current_stylist.kiqs
    end
end
