class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :turbolinks_app?

  def turbolinks_app?
    @turbolinks_ap ||= request.user_agent.to_s.include?("turbolinks-app")
  end

  before_action do
    resource = controller_name.singularize.to_sym
  end

  def require_no_sso!
    redirect_to auth_sso_path if Setting.sso_enabled?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  before_action do
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(*User::ACCESSABLE_ATTRS) } if devise_controller?
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |user|
  #     user.permit(:login, :name, :email_public, :email, :password, :password_confirmation)
  #   end
  # end
end
