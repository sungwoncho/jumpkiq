class KiqsController < ApplicationController
  before_action :authenticate_user_or_stylist!, except: :update
  before_action :authenticate_stylist!, only: :update
  before_action :set_kiq, only: [:show, :update, :destroy]
  before_action :get_status, only: :update

  def index
    @kiqs = current_user.kiqs
  end

  def show
  end

  def create
    unless current_user.ready_to_order?
      render nothing: true, status: :method_not_allowed
      return
    end

    if current_user.requested_kiqs.present?
      render json: 'You have already requested a kiq'
    else
      @kiq = current_user.kiqs.create
      current_user.stylist.kiqs << @kiq
      render :show
    end
  end

  def update
    case @status
    when 'pending' then @kiq.update(status: 'pending')
    when 'completed' then @kiq.update(status: 'completed')
    end
    render :show
  end

  def destroy
    if @kiq.status == 'requested'
      @kiq.update(status: 'cancelled')
      render :show
    else
      render nothing: true, status: :method_not_allowed
    end
  end

  protected

    def authenticate_user_or_stylist!
      authenticate_user! || authenticate_stylist!
    end

    def set_kiq
      @kiq = Kiq.find(params[:id])
    end

    def get_status
      @status = params[:status]
    end
end
