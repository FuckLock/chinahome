class Reply < ApplicationRecord
  include MarkdownBody
  validates :body, presence: true
  belongs_to :user, touch: true
  belongs_to :topic, touch: true
  has_many :notifications,-> { where(notify_type: 'mention', ancestry_type: 'Topic',
                          second_ancestry_type: 'Reply') }, foreign_key: :second_ancestry_id

  scope :without_action, -> { where("action is null") }

  after_commit :create_notifications, on: [:create]

  def create_notifications
    return nil unless mention_user?
    self.mentioned_user_ids.each do |target_id|
      if target_id != self.user_id
        Notification.create(
          subject_id: self.user.id,
          notify_type: 'mention',
          target_id: target_id,
          ancestry_type: 'Topic',
          ancestry_id: self.topic.id,
          second_ancestry_type: 'Reply',
          second_ancestry_id: self.id
        )
      end
    end
  end

  def mention_user?
    self.mentioned_user_ids.present?
  end

  class << self
    def create_action(opts = {})
      opts[:body] ||= ""
      opts[:user] ||= User.current
      return false if opts[:action].blank?
      return false if opts[:user].blank?
      self.create(opts)
    end
  end
end
