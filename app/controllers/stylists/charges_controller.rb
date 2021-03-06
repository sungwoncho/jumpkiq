class Stylists::ChargesController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_kiq
  before_action :set_user
  before_action :set_amount

  def create
    if @kiq.status == 'sent'
      @payment = Stripe::Charge.create(amount: @amount, currency: 'aud', customer: @user.stripe_customer_id)
      @kiq.update(status: 'completed')
      redirect_to :back, notice: 'Successfully charged the kiq'
    else
      render nothing: true, status: :method_not_allowed
    end
  end

  def destroy
    render nothing: true
  end

  protected
    def set_kiq
      @kiq = Kiq.find(params[:id])
    end

    def set_user
      @user = @kiq.user
    end

    def set_amount
      @amount = params[:amount].to_i
    end
end
