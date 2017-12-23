class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.integer  'user_id',            null: false
      t.integer  'topic_id',           null: false
      t.text     'body',               null: false
      t.text     'body_html'
      t.integer  'state',              default: 1,  null: false
      t.integer  'liked_user_ids',     default: [], array: true
      t.integer  'likes_count',        default: 0
      t.integer  'mentioned_user_ids', default: [], array: true
      t.datetime 'deleted_at'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index 'replies', ['topic_id']
    add_index 'replies', ['user_id']
  end
end
