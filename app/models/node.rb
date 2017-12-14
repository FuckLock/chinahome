class Node < ApplicationRecord
  belongs_to :section
  validates :name, presence: true, uniqueness: true
  validates :section_id, presence: true
end
