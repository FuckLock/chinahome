# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180103090847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "action_type"
    t.string   "target_type"
    t.integer  "target_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_id", "subject_type", "action_type"], name: "index_actions_on_subject_id_and_subject_type_and_action_type", using: :btree
    t.index ["target_id", "target_type", "action_type"], name: "index_actions_on_target_id_and_target_type_and_action_type", using: :btree
  end

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider",                null: false
    t.string   "uid",        limit: 1000, null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", using: :btree
  end

  create_table "exception_tracks", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "summary"
    t.integer  "section_id",               null: false
    t.integer  "sort",         default: 0, null: false
    t.integer  "topics_count", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["section_id"], name: "index_nodes_on_section_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "topic_id",                        null: false
    t.text     "body",                            null: false
    t.text     "body_html"
    t.integer  "state",              default: 1,  null: false
    t.integer  "liked_user_ids",     default: [],              array: true
    t.integer  "likes_count",        default: 0
    t.integer  "mentioned_user_ids", default: [],              array: true
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action"
    t.string   "ban_title"
    t.index ["topic_id"], name: "index_replies_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_replies_on_user_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "sort",       default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["sort"], name: "index_sections_on_sort", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "user_id",                               null: false
    t.integer  "node_id",                               null: false
    t.string   "title",                                 null: false
    t.text     "body",                                  null: false
    t.text     "body_html"
    t.integer  "last_reply_id"
    t.integer  "last_reply_user_id"
    t.string   "last_reply_user_login"
    t.string   "node_name"
    t.string   "who_deleted"
    t.integer  "last_active_mark"
    t.boolean  "lock_node",             default: false
    t.datetime "suggested_at"
    t.integer  "excellent",             default: 0
    t.datetime "replied_at"
    t.integer  "replies_count",         default: 0,     null: false
    t.integer  "likes_count",           default: 0
    t.integer  "follower_ids",          default: [],                 array: true
    t.integer  "liked_user_ids",        default: [],                 array: true
    t.integer  "mentioned_user_ids",    default: [],                 array: true
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "discuss",               default: true
    t.index ["excellent"], name: "index_topics_on_excellent", using: :btree
    t.index ["last_active_mark"], name: "index_topics_on_last_active_mark", using: :btree
    t.index ["likes_count"], name: "index_topics_on_likes_count", using: :btree
    t.index ["node_id"], name: "index_topics_on_node_id", using: :btree
    t.index ["suggested_at"], name: "index_topics_on_suggested_at", using: :btree
    t.index ["user_id"], name: "index_topics_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",                                  null: false
    t.string   "name"
    t.string   "email",                                  null: false
    t.string   "email_md5",                              null: false
    t.boolean  "email_public",           default: false, null: false
    t.string   "location"
    t.integer  "location_id"
    t.string   "bio"
    t.string   "website"
    t.string   "company"
    t.string   "github"
    t.string   "twitter"
    t.string   "qq"
    t.string   "avatar"
    t.boolean  "verified",               default: false, null: false
    t.boolean  "hr",                     default: false, null: false
    t.integer  "state",                  default: 1,     null: false
    t.string   "tagline"
    t.string   "co"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt",          default: "",    null: false
    t.string   "persistence_token",      default: "",    null: false
    t.string   "single_access_token",    default: "",    null: false
    t.string   "perishable_token",       default: "",    null: false
    t.integer  "topics_count",           default: 0,     null: false
    t.integer  "replies_count",          default: 0,     null: false
    t.string   "private_token"
    t.integer  "favorite_topic_ids",     default: [],                 array: true
    t.integer  "blocked_node_ids",       default: [],                 array: true
    t.integer  "blocked_user_ids",       default: [],                 array: true
    t.integer  "following_ids",          default: [],                 array: true
    t.integer  "follower_ids",           default: [],                 array: true
    t.string   "type"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["location"], name: "index_users_on_location", using: :btree
    t.index ["login"], name: "index_users_on_login", using: :btree
    t.index ["private_token"], name: "index_users_on_private_token", using: :btree
  end

end
