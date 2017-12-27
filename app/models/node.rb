class Node < ApplicationRecord
  has_many :topics
  has_many :block_user_actions, -> { where(subject_type: "User", action_type: "block", target_type: "Node") },
    foreign_key: :target_id,
    class_name: "Action"

  has_many :block_users, through: :block_user_actions, source: :subject, source_type: "User"

  belongs_to :section
  validates :name, presence: true, uniqueness: true
  validates :section_id, presence: true
end
