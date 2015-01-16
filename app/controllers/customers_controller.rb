class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_token, only: :create

  def create
    begin
      customer = Stripe::Customer.create(card: @token)
      current_user.update_stripe_customer_id(customer.id)

      render :show
    rescue Stripe::InvalidRequestError => e
      render json: e.message, status: 400
    end
  end

  def update
  end

  def destroy
  end

  protected
    def set_token
      @token = params[:stripeToken]
    end
end
