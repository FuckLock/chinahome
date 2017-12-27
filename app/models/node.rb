class Node < ApplicationRecord
  has_many :topics
  has_many :block_user_actions, -> { where(user_type: "User", target_type: "Node", action_type: "block") },
    foreign_key: :target_id,
    class_name: "Action"

  has_many :block_users, through: :block_user_actions, source: :user, source_type: "User"

  belongs_to :section
  validates :name, presence: true, uniqueness: true
  validates :section_id, presence: true
end
