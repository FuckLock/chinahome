require "digest/md5"

class User < ApplicationRecord
  include OmniauthCallbacks

  mount_uploader :avatar, AvatarUploader
  second_level_cache expires_in: 2.weeks

  LOGIN_FORMAT = 'A-Za-z0-9\-\_\.'
  ALLOW_LOGIN_FORMAT_REGEXP = /\A[#{LOGIN_FORMAT}]+\z/

  has_many :authorizations, dependent: :destroy
  has_many :topics
  has_many :replies
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  ACCESSABLE_ATTRS = %i[name email_public location company bio website github twitter
                        tagline avatar by current_password password password_confirmation]
  validates :login, format: { with: ALLOW_LOGIN_FORMAT_REGEXP, message: "只允许数字、大小写字母、中横线、下划线" },
                    presence: true,
                    length: { in: 2..20 },
                    uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 20 }

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

  def self.find_by_login(slug)
    return nil unless slug.match ALLOW_LOGIN_FORMAT_REGEXP
    fetch_by_uniq_keys(login: slug) || where("lower(login) = ?", slug.downcase).take
  end

  def admin?
    Setting.has_admin?(email)
  end
end
