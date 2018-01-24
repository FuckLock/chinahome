require "digest/md5"

class User < ApplicationRecord
  include OmniauthCallbacks
  include Actionable
  include LetterAvatar::AvatarHelper

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

  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)
    Thread.current[:current_user] = user
  end

  def unread_count
    count = self.notifications.unread.count
    count == 0 ? nil : count
  end

  def self.search(term, options = {})
    limit = options[:limit].to_i
    term = term.to_s + "%"
    users = User.where("login ilike ? or name ilike ?", term, term).order("replies_count desc").limit(limit).to_a
    users.uniq!
    users.compact!
    users.first(limit)
  end

  def large_avatar_url
    if self[:avatar].present?
      self.avatar.url(:lg)
    else
      self.letter_avatar_url(login)
    end
  end

  def calendar_data
    date_from = 12.months.ago.beginning_of_month.to_date
    replies = self.replies.where("created_at > ?", date_from)
                  .group("date(created_at)")
                  .select("date(created_at) AS date, count(id) AS total_amount")

    replies.each_with_object({}) do |reply, timestamps|
      timestamps[reply["date"].to_time.to_i.to_s] = reply["total_amount"]
    end
  end

end
