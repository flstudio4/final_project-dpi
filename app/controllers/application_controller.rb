class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!, except: [:welcome]
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :gender, :avatar, :country, :state, :city, :dob, :bio, :name)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :avatar, :country, :state, :city, :bio, :password, :password_confirmation, :current_password, :name)}
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || dashboard_path)
  end
end
