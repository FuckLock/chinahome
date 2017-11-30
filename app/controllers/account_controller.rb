class AccountController < Devise::RegistrationsController
  before_action :require_no_sso!, only: %i[new create]

  def create
    build_resource(sign_up_params)
    resource.login = params[resource_name][:login]
    resource.email = params[resource_name][:email]
    sign_in(resource_name, resource) if resource.save
  end
end
