class User
  module OmniauthCallbacks
    extend ActiveSupport::Concern

    module ClassMethods
      %w[github].each do |provider|
        define_method "find_or_create_for_#{provider}" do |response|
          uid = response.uid
          user = Authorization.find_by(provider: provider, uid: uid).try(:user)
          return user if user
          data = response.info
          user = User.new_from_provider_data(provider, uid, data)
          if user.save(validate: false)
            Authorization.find_or_create_by(provider: provider, uid: uid, user_id: user.id)
            return user
          else
            Rails.logger.warn("User.create_from_hash 失败，#{user.errors.inspect}")
            return nil
          end
        end
      end

      def new_from_provider_data(provider, _uid, data)
        User.new do |user|
          user.email = data.email
          user.name = data.name
          user.login = data.nickname
          user.github = data.nickname if provider == "github"
          user.login = "u#{Time.now.to_i}" if user.login.blank?
          user.password = Devise.friendly_token[0, 20]
        end
      end
    end
  end
end
