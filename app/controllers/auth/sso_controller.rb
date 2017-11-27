class Auth::SsoController < ApplicationController
  def show
    return render_404 unless Setting.sso_enabled?
  end
end
