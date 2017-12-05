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

ActiveRecord::Schema.define(version: 20171204055520) do

  create_table "authorizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider",                null: false
    t.string   "uid",        limit: 1000, null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "var",                      null: false
    t.text     "value",      limit: 65535
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.integer  "favorite_topic_ids"
    t.integer  "blocked_node_ids"
    t.integer  "blocked_user_ids"
    t.integer  "following_ids"
    t.integer  "follower_ids"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["location"], name: "index_users_on_location", using: :btree
    t.index ["login"], name: "index_users_on_login", using: :btree
    t.index ["private_token"], name: "index_users_on_private_token", using: :btree
  end

end
