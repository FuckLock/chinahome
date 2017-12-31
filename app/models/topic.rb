class Topic < ApplicationRecord
  include MarkdownBody

  belongs_to :node, touch: true
  belongs_to :user, touch: true
  has_many :replies

  scope :no_reply, -> { where(replies_count: 0) }
  scope :exclude_column_ids, ->(ids) { where.not(node_id: ids) }
end
