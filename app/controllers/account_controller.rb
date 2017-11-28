class AccountController < Devise::RegistrationsController
  before_action :require_no_sso!, only: [:new, :create]

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    resource.login = params[resource_name][:login]
    resource.email = params[resource_name][:email]
    if resource.save
      sign_in(resource_name, resource)
    end
  end

end
