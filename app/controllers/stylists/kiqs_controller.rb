class Stylists::KiqsController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_status, only: :index
  before_action :set_kiq, except: :index

  respond_to :html

  def index
    if ['requested', 'pending', 'completed'].include? @status
      @kiqs = Kiq.where(status: @status)
    else
      @kiqs = Kiq.all
    end
  end

  def show
  end

  def edit
  end

  def update
    @kiq.update(kiq_params)
    respond_with(:stylists, @kiq)
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
