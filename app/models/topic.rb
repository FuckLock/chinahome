class Topic < ApplicationRecord
  include MarkdownBody

  belongs_to :node
  belongs_to :user
  has_many :replies

end
