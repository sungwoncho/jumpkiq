class KiqsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kiq, only: [:show, :update, :destroy]
  before_action :get_status, only: :update

  def index
    @kiqs = current_user.kiqs.order(created_at: :desc)
  end

  def show
  end

  def create
    if current_user.ready_to_order?
      @kiq = current_user.kiqs.new(stylist_id: current_user.stylist.id)

      if @kiq.save
        KiqsMailer.new_order(@kiq).deliver_later
        render :show
      end
    else
      head status: :method_not_allowed
    end
  end

  def destroy
    if @kiq.status == 'requested'
      @kiq.update(status: 'cancelled')
      render :show
    else
      head status: :method_not_allowed
    end
  end

  protected

    def set_kiq
      @kiq = Kiq.find(params[:id])
    end

    def get_status
      @status = params[:status]
    end
end
