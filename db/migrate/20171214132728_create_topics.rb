class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.integer  'user_id',                            null: false
      t.integer  'node_id',                            null: false
      t.string   'title',                              null: false
      t.text     'body',                               null: false
      t.text     'body_html'
      t.integer  'last_reply_id'
      t.integer  'last_reply_user_id'
      t.string   'last_reply_user_login'
      t.string   'node_name'
      t.string   'who_deleted'
      t.integer  'last_active_mark'
      t.boolean  'lock_node', default: false
      t.datetime 'suggested_at'
      t.integer  'excellent', default: 0
      t.datetime 'replied_at'
      t.integer  'replies_count',      default: 0, null: false
      t.integer  'likes_count',        default: 0
      t.integer  'follower_ids',       default: [],                 array: true
      t.integer  'liked_user_ids',     default: [],                 array: true
      t.integer  'mentioned_user_ids', default: [],                 array: true
      t.datetime 'deleted_at'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    add_index :topics, %w[excellent]
    add_index :topics, %w[last_active_mark]
    add_index :topics, %w[likes_count]
    add_index :topics, %w[node_id]
    add_index :topics, %w[suggested_at]
    add_index :topics, %w[user_id]
  end
end
