class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :html, :json, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :password, :password_confirmation,
          :firstname, :lastname,
          :height, :weight, :casual_shirt_size,
          :long_sleeve, :short_sleeve, :polo_shirt, :pants, :shorts,
          :smart_kiq, :casual_kiq, :hipster_kiq, :classic_kiq)
      end
    end

end
