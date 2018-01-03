class Topic < ApplicationRecord
  include MarkdownBody

  belongs_to :node, touch: true
  belongs_to :user, touch: true
  has_many :replies

  scope :no_reply, -> { where(replies_count: 0) }
  scope :exclude_column_ids, ->(ids) { where.not(node_id: ids) }

  def excellent!
    transaction do
      update_attribute(:excellent, 1)
      Reply.create_action(topic_id: self.id, action: "excellent", body: "将本帖设为了精华贴")
    end
  end

  def unexcellent!
    transaction do
      update_attribute(:excellent, 0)
      Reply.create_action(topic_id: self.id, action: "unexcellent", body: "取消了精华贴")
    end
  end

  def ban! opts = {}
    transaction do
      update_attributes(lock_node: true, node_id: Node.no_point.id, node_name: "NoPoint")
      if opts[:reason] && opts[:reason_text]
        Reply.create_action(topic_id: self.id, action: "ban", body: opts[:reason_text], ban_title: opts[:reason])
      end
    end
  end

  def close!
    transaction do
      update_attribute(:discuss, false)
      Reply.create_action(topic_id: self.id, action: "colse", body: "关闭了讨论")
    end
  end

  def open!
    transaction do
      update_attribute(:discuss, true)
      Reply.create_action(topic_id: self.id, action: "open", body: "重新开启了讨论")
    end
  end

end
