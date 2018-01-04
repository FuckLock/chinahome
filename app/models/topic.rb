class Topic < ApplicationRecord
  include MarkdownBody

  belongs_to :node, touch: true
  belongs_to :user, touch: true
  has_many :replies, dependent: :destroy

  scope :no_reply,              -> { where(replies_count: 0) }
  scope :without_ban,           -> { where.not(ban: true) }
  scope :place_top,             -> { where(place_top: true).order(suggested_at: :desc) }
  scope :without_place_top,     -> { where(place_top: false) }

  scope :exclude_column_ids,    ->(ids) { where.not(node_id: ids) }

  def place_top!
    transaction do
      update_attributes(place_top: true, suggested_at: Time.now)
    end
  end

  def cancel!
    transaction do
      update_attribute(:place_top, false)
    end
  end

  def excellent!
    transaction do
      update_attribute(:excellent, true)
      Reply.create_action(topic_id: self.id, action: "excellent", body: "将本帖设为了精华贴")
    end
  end

  def unexcellent!
    transaction do
      update_attribute(:excellent, false)
      Reply.create_action(topic_id: self.id, action: "unexcellent", body: "取消了精华贴")
    end
  end

  def banban!(opts = {})
    transaction do
      update_attributes(node_id: Node.no_point.id, node_name: "NoPoint", ban: true)
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
