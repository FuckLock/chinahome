class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  helper_method :turbolinks_app?

  def turbolinks_app?
    @turbolinks_ap ||= request.user_agent.to_s.include?("turbolinks-app")
  end

  def require_no_sso!
    redirect_to auth_sso_path if Setting.sso_enabled?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(*User::ACCESSABLE_ATTRS) } if devise_controller?

    User.current = current_user
  end
end
