class Action < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :target, polymorphic: true
end
