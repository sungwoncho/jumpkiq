module API
  class CustomersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_token, except: [:destroy, :show]
    before_action :retrieve_customer, except: [:create, :show]

    rescue_from Stripe::InvalidRequestError do |e|
      render json: e.message, status: 400
    end

    def show
      customer_id = current_user.stripe_customer_id
      @customer = Stripe::Customer.retrieve(customer_id) if customer_id
    end

    def create
      @customer = Stripe::Customer.create(card: @token)
      current_user.update_stripe_customer_id(@customer.id)

      render :show
    end

    def update
      @customer.card = @token
      @customer.save

      render :show
    end

    def destroy

      unless current_user.requested_kiqs.present? || current_user.sent_kiqs.present?
        @customer.delete
        current_user.update_stripe_customer_id(nil)

        @customer = nil
        render :show, status: 200
      else
        render nothing: true, status: :method_not_allowed
      end
    end

    protected
      def set_token
        @token = params[:stripeToken]
      end

      def retrieve_customer
        customer_id = current_user.stripe_customer_id
        @customer = Stripe::Customer.retrieve(customer_id)
      end
  end
end
