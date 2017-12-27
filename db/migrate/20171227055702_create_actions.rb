class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.integer :subject_id
      t.string :subject_type
      t.string :action_type
      t.string :target_type
      t.integer :target_id

      t.timestamps
    end

    add_index :actions, %w[subject_type subject_id action_type]
    add_index :actions, %w[target_type target_id action_type]
  end
end
