class Reply < ApplicationRecord
  include MarkdownBody
  validates :body, presence: true
  belongs_to :user, touch: true
  belongs_to :topic, touch: true
end
