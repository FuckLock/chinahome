class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string "name", null: false
      t.string "summary"
      t.integer "section_id", null: false
      t.integer "sort", default: 0, null: false
      t.integer "topics_count", default: 0, null: false
      t.timestamps
    end

    add_index :nodes, %w[section_id]
  end
end
