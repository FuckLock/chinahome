class AddColumnFloorToReplies < ActiveRecord::Migration[5.0]
  def change
    remove_column :replies, :floor
    add_column :replies, :floor, :string
  end
end
