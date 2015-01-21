class Stylists::KiqsController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_status, only: :index
  before_action :set_kiq, except: :index

  respond_to :html

  def index
    if ['requested', 'sent', 'completed', 'cancelled'].include? @status
      @kiqs = Kiq.where(stylist: current_stylist, status: @status)
    else
      @kiqs = current_stylist.kiqs
    end
  end

  def show
  end

  def edit
  end

  def update
    if @kiq.update(kiq_params)
      redirect_to :back, notice: 'successfully updated the status!'
    end
  end


  private
    def set_status
      @status = params[:status]
    end

    def set_kiq
      @kiq = Kiq.find(params[:id])
    end

    def kiq_params
      params.require(:kiq).permit(:status)
    end
end
