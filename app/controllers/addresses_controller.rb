class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_address, only: [:show, :update, :destroy]

  def show
  end

  def create
    @address = Address.new(address_params)

    if @address.save && @address.update(user_id: @user.id)
      render :show
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      render :show
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.requested_kiqs.present? || current_user.sent_kiqs.present?
      render nothing: true, status: :method_not_allowed
    else
      @address.destroy
      head 204
    end
  end

  private
    def set_user
      @user = current_user
    end

    def set_address
      @address = @user.address
    end

    def address_params
      params.require(:address).permit(:street_address, :secondary_address, :city, :state, :postcode)
    end
end
