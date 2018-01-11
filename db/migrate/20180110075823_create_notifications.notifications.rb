# This migration comes from notifications (originally 20160328045436)
class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :subject_id, null: false
      t.string :notify_type, null: false
      t.integer :target_id
      t.string :ancestry_type
      t.integer :ancestry_id
      t.string :second_ancestry_type
      t.integer :second_ancestry_id
      t.string :third_ancestry_type
      t.integer :third_ancestry_id
      t.datetime :read_at

      t.timestamps null: false
    end

    add_index :notifications, [:target_id, :notify_type]
    add_index :notifications, [:target_id]
  end
end
