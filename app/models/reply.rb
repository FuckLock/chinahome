class Reply < ApplicationRecord
  include MarkdownBody
  validates :body, presence: true
  belongs_to :user, touch: true
  belongs_to :topic, touch: true

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
