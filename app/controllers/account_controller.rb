class AccountController < Devise::RegistrationsController
  before_action :require_no_sso!, only: %i[new create]

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    
  end
end
