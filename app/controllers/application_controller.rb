class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[name, email, password, password_confirmation]
  end

  def new_session_path(scope)
    root_path
  end

  private

  def current_campaign
    return @current_campaign if @current_campaign
    return nil unless user_signed_in?
    @current_campaign = current_user.current_campaign
  end
  helper_method :current_campaign

  def current_membership
    @current_membership ||= current_campaign.membership_for(current_user)
  end
  helper_method :current_membership

  def authorize_referee!
    redirect_to root_path, alert: "Only referees can do that!" unless current_membership.referee?
  end
end
