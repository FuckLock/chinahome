class AddColumnActionToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :action, :string
  end
end
