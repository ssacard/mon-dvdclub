# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110211063340) do

  create_table "actors", :force => true do |t|
    t.string "name"
  end

  create_table "blacklistings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_id_target"
    t.boolean  "source_forgot"
    t.boolean  "target_forgot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocked_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dvd_club_id"
    t.integer  "blocked_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directors", :force => true do |t|
    t.string "name"
  end

  create_table "directors_dvds", :id => false, :force => true do |t|
    t.integer "director_id"
    t.integer "dvd_id"
  end

  add_index "directors_dvds", ["director_id"], :name => "directors_has_dvds_FKIndex1"
  add_index "directors_dvds", ["dvd_id"], :name => "directors_has_dvds_FKIndex2"

  create_table "dvd_categories", :force => true do |t|
    t.string "name"
  end

  create_table "dvd_clubs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id",   :limit => 10
    t.string   "state"
  end

  create_table "dvd_formats", :force => true do |t|
    t.string "name"
  end

  create_table "dvds", :force => true do |t|
    t.integer  "dvd_category_id"
    t.integer  "format_id"
    t.string   "asin"
    t.text     "details_url"
    t.datetime "created_at"
    t.integer  "owner_id",        :limit => 10
    t.string   "title"
    t.string   "smallimage"
    t.string   "largeimage"
    t.text     "description"
    t.string   "state"
    t.integer  "booked_by"
    t.datetime "booked_at"
  end

  add_index "dvds", ["dvd_category_id"], :name => "altered_dvds_FKIndex3"
  add_index "dvds", ["format_id"], :name => "altered_dvds_FKIndex2"

  create_table "dvds_actors", :id => false, :force => true do |t|
    t.integer "actor_id"
    t.integer "dvd_id"
  end

  add_index "dvds_actors", ["actor_id"], :name => "dvds_has_actors_FKIndex2"
  add_index "dvds_actors", ["dvd_id"], :name => "dvds_has_actors_FKIndex1"

  create_table "invitations", :force => true do |t|
    t.integer  "dvd_club_id"
    t.integer  "user_id"
    t.string   "token"
    t.string   "email"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string "name"
  end

  create_table "manufacturers_dvds", :id => false, :force => true do |t|
    t.integer "manufacturer_id"
    t.integer "dvd_id"
  end

  add_index "manufacturers_dvds", ["dvd_id"], :name => "manufacturers_has_dvds_FKIndex2"
  add_index "manufacturers_dvds", ["manufacturer_id"], :name => "manufacturers_has_dvds_FKIndex1"

  create_table "roles", :force => true do |t|
    t.string   "authorizable_type", :limit => 100
    t.integer  "authorizable_id",   :limit => 10
    t.string   "name",              :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :limit => 10, :null => false
    t.integer "user_id", :limit => 10, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.integer  "max_clubs"
    t.integer  "max_club_members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_dvd_clubs", :force => true do |t|
    t.integer  "dvd_club_id"
    t.integer  "user_id"
    t.string   "description"
    t.boolean  "subscription_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comments"
    t.integer  "invited_by_id"
  end

  add_index "user_dvd_clubs", ["dvd_club_id"], :name => "altered_user_dvd_clubs_FKIndex2"
  add_index "user_dvd_clubs", ["user_id"], :name => "altered_user_dvd_clubs_FKIndex1"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "password_secret",           :limit => 40
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accept_offers",             :limit => 3
    t.datetime "remember_token_expires_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.string   "facebook_id"
  end

  create_table "waiting_lists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dvd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "waiting_lists", ["dvd_id"], :name => "waiting_lists_FKIndex1"
  add_index "waiting_lists", ["user_id"], :name => "waiting_lists_FKIndex2"

end
