class Section < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :nodes, dependent: :destroy
end
