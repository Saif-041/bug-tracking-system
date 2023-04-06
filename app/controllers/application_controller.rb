# frozen_string_literal: true

# This class ApplicationController < ActionController::Base# Actions
class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :manager?
  def manager?
    current_user && (current_user.user_type == '0' || current_user.user_type == 'Manager')
  end

  helper_method :qa?
  def qa?
    current_user && (current_user.user_type == '1' || current_user.user_type == 'QA')
  end

  helper_method :developer?
  def developer?
    current_user && (current_user.user_type == '2' || current_user.user_type == 'Developer')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:user_type, :name, :email, :password, :password_confirmation)
    end
  end

  private

  def remember_page
    session[:previous_pages] ||= []
    session[:previous_pages] << url_for(params.to_unsafe_h) if request.get?
    session[:previous_pages] = session[:previous_pages].uniq.first(2)
  end
end
