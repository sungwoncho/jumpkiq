class StylistsController < ApplicationController
  before_action :authenticate_stylist!

  def dashboard
    @kiqs = current_stylist.kiqs
  end
end
