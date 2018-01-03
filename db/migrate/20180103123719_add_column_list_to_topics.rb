class AddColumnListToTopics < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :excellent
    add_column :topics, :place_top, :boolean, default: false
    add_column :topics, :excellent, :boolean, default: false
    add_column :topics, :ban, :boolean, default: false
    add_index :topics, %w[place_top]
    add_index :topics, %w[excellent]
    add_index :topics, %w[discuss]
    add_index :topics, %w[ban]
  end
end
