class AddColumnTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :type, :string
  end
end
