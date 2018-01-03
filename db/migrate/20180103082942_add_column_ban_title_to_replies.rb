class AddColumnBanTitleToReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :ban_title, :string
  end
end
