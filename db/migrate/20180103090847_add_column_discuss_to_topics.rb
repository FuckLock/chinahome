class AddColumnDiscussToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :discuss, :boolean, default: true
  end
end
