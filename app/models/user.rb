require "digest/md5"

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ACCESSABLE_ATTRS = %i[name email_public location company bio website github twitter
                        tagline avatar by current_password password password_confirmation]

  def email=(val)
    self.email_md5 = Digest::MD5.hexdigest(val || "")
    self[:email] = val
  end
end
