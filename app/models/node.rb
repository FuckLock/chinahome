class Node < ApplicationRecord
  has_many :topics

  belongs_to :section
  validates :name, presence: true, uniqueness: true
  validates :section_id, presence: true

  scope :no_point, -> { find_by(name: "NoPoint") }
  scope :node_name, ->(id) { find_by(id: id).name }
end
