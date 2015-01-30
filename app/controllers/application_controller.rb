class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  respond_to :html, :json, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :record_last_active_at

  def after_sign_in_path_for(resource)
    case resource
    when User then '/profile/main'
    when Stylist then stylists_dashboard_path
    end
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :password, :password_confirmation,
          :firstname, :lastname,
          :height, :weight, :casual_shirt_size, :waist, :inseam,
          :long_sleeve, :short_sleeve, :polo_shirt, :pants, :shorts,
          :smart_style, :casual_style, :hipster_style, :classic_style)
      end
    end

    def record_last_active_at
      current_user.touch :last_active_at if current_user
    end

end
