module Auth
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    %w[github].each do |provider|
      define_method provider.to_s do
        @user = User.find_or_create_for_github(request.env["omniauth.auth"])
        if @user.persisted?
          flash[:notice] = t("devise.sessions.user.signed_in")
          sign_in_and_redirect @user, event: :authentication
        else
          redirect_to new_user_registration_url
        end
      end
    end
  end
end
