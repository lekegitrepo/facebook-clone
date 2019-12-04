class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :check_logged_in_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:first_name, :last_name, :username])
  end

  def check_logged_in_user
    redirect_to new_user_registration_path unless user_signed_in?
  end
end
