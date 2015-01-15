class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_address, only: [:show, :update]

  def show
  end

  def create
    @address = Address.new(address_params)

    if @address.save && @user.address = @address
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

  protected
    def set_user
      @user = current_user
    end

    def set_address
      @address = @user.address
    end

  private
    def address_params
      params.require(:address).permit(:street_address, :secondary_address, :city, :state, :postcode)
    end
end
