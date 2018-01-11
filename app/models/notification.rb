class Notification < ActiveRecord::Base

  belongs_to :subject, class_name: "User"
  belongs_to :ancestry, class_name: "Topic"
  belongs_to :second_ancestry, class_name: "Reply"

end
