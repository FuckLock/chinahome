class Reply < ApplicationRecord
  include MarkdownBody
  validates :body, presence: true
  belongs_to :user
  belongs_to :topic
end
