class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :html, :json, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    '/profile/main'
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :password, :password_confirmation,
          :firstname, :lastname,
          :height, :weight, :casual_shirt_size, :waist, :inseam,
          :long_sleeve, :short_sleeve, :polo_shirt, :pants, :shorts,
          :smart_style, :casual_style, :hipster_style, :classic_style)
      end
    end

end
