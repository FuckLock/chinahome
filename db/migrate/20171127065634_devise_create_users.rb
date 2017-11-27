class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   'login',                                  null: false
        t.string   'name',                                   null: false
        t.string   'email',                                  null: false
        t.string   'email_md5',                              null: false
        t.boolean  'email_public', default: false, null: false
        t.string   'location'
        t.integer  'location_id'
        t.string   'bio'
        t.string   'website'
        t.string   'company'
        t.string   'github'
        t.string   'twitter'
        t.string   'qq'
        t.string   'avatar'
        t.boolean  'verified',               default: false, null: false
        t.boolean  'hr',                     default: false, null: false
        t.integer  'state',                  default: 1,     null: false
        t.string   'tagline'
        t.string   'co'
        t.datetime 'created_at'
        t.datetime 'updated_at'
        t.string   'encrypted_password', default: '', null: false
        t.string   'reset_password_token'
        t.datetime 'reset_password_sent_at'
        t.datetime 'remember_created_at'
        t.integer  'sign_in_count', default: 0, null: false
        t.datetime 'current_sign_in_at'
        t.datetime 'last_sign_in_at'
        t.string   'current_sign_in_ip'
        t.string   'last_sign_in_ip'
        t.string   'password_salt',          default: '',    null: false
        t.string   'persistence_token',      default: '',    null: false
        t.string   'single_access_token',    default: '',    null: false
        t.string   'perishable_token',       default: '',    null: false
        t.integer  'topics_count',           default: 0,     null: false
        t.integer  'replies_count',          default: 0,     null: false
        t.string   'private_token'
        t.integer  'favorite_topic_ids',     default: [],                 array: true
        t.integer  'blocked_node_ids',       default: [],                 array: true
        t.integer  'blocked_user_ids',       default: [],                 array: true
        t.integer  'following_ids',          default: [],                 array: true
        t.integer  'follower_ids',           default: [],                 array: true
      end

      add_index 'users', ['email'], name: 'index_users_on_email', using: :btree
      add_index 'users', ['location'], name: 'index_users_on_location', using: :btree
      add_index 'users', ['login'], name: 'index_users_on_login', using: :btree
      add_index 'users', ['private_token'], name: 'index_users_on_private_token', using: :btree
  end
end
