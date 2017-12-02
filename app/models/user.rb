require "digest/md5"

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ACCESSABLE_ATTRS = %i[name email_public location company bio website github twitter
                        tagline avatar by current_password password password_confirmation]
  validates :login, presence: true,
                    length: { in: 2..20 },
                    uniqueness: { case_sensitive: false }

  def email=(val)
    self.email_md5 = Digest::MD5.hexdigest(val || "")
    self[:email] = val
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    login.downcase!
    where(["lower(login) = :value OR lower(email) = :value and state != -1", { value: login }]).first
  end
end
