class SessionsController < Devise::RegistrationsController

  def create
    resource = warden.authenticate!(scope: resource_name)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_to  do |format|
      format.html { redirect_back_or_default(root_url) }
      format.json { render status: "201", json: resource.as_json(only: [:login, :email]) }
    end
  end

end
