class AddColumnFloorToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :floor, :string
  end
end
