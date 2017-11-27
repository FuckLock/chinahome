class AccountController < Devise::RegistrationsController
  before_action :require_no_sso!, only: [:new, :create]

  def new
    super
  end

end
