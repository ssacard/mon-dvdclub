class DvdModel < ActiveRecord::Migration
  def self.up
    create_table "actors", :force => true do |t|
      t.string "name"
    end
  
    create_table "club_topics", :force => true do |t|
      t.string "name"
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
      t.integer   "club_topic_id"
      t.string    "name"
      t.text      "description"
      t.timestamp "created_at"
      t.timestamp "updated_at"
      t.integer   "owner_id",      :limit => 10
    end
  
    add_index "dvd_clubs", ["club_topic_id"], :name => "dvd_clubs_FKIndex1"
  
    create_table "dvds", :force => true do |t|
      t.integer   "dvd_category_id"
      t.integer   "format_id"
      t.integer   "dvd_club_id"
      t.string    "asin"
      t.text      "details_url"
      t.string    "subscription_status"
      t.timestamp "created_at"
      t.integer   "owner_id",            :limit => 10
      t.string    "title"
      t.string    "logo"
      t.text      "description"
    end
  
    add_index "dvds", ["dvd_club_id"], :name => "dvds_FKIndex1"
    add_index "dvds", ["format_id"], :name => "dvds_FKIndex2"
    add_index "dvds", ["dvd_category_id"], :name => "dvds_FKIndex3"
  
    create_table "dvds_actors", :id => false, :force => true do |t|
      t.integer "actor_id"
      t.integer "dvd_id"
    end
  
    add_index "dvds_actors", ["dvd_id"], :name => "dvds_has_actors_FKIndex1"
    add_index "dvds_actors", ["actor_id"], :name => "dvds_has_actors_FKIndex2"
  
    create_table "dvd_formats", :force => true do |t|
      t.string "name"
    end
  
    create_table "manufacturers", :force => true do |t|
      t.string "name"
    end
  
    create_table "manufacturers_dvds", :id => false, :force => true do |t|
      t.integer "manufacturer_id"
      t.integer "dvd_id"
    end
  
    add_index "manufacturers_dvds", ["manufacturer_id"], :name => "manufacturers_has_dvds_FKIndex1"
    add_index "manufacturers_dvds", ["dvd_id"], :name => "manufacturers_has_dvds_FKIndex2"
  
    create_table "user_dvd_clubs", :force => true do |t|
      t.integer   "dvd_club_id"
      t.integer   "user_id"
      t.string    "subscription_status"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
  
    add_index "user_dvd_clubs", ["user_id"], :name => "user_dvd_clubs_FKIndex1"
    add_index "user_dvd_clubs", ["dvd_club_id"], :name => "user_dvd_clubs_FKIndex2"
  
    create_table "users", :force => true do |t|
      t.string    "login"
      t.string    "email"
      t.string    "crypted_password",          :limit => 40
      t.string    "salt",                      :limit => 40
      t.string    "remember_token"
      t.timestamp "created_at"
      t.timestamp "updated_at"
      t.integer   "accept_offers", :limit => 3
      t.datetime  "remember_token_expires_at"
      t.timestamp "deleted_at"
    end
  
    create_table "waiting_lists", :force => true do |t|
      t.integer   "user_id"
      t.integer   "dvd_id"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
  
    add_index "waiting_lists", ["dvd_id"], :name => "waiting_lists_FKIndex1"
    add_index "waiting_lists", ["user_id"], :name => "waiting_lists_FKIndex2"
    
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
  end

  def self.down
    drop_table :actors
    drop_table :directors
    drop_table :dvds
    drop_table :directors_dvds
    drop_table :manufacturers
    drop_table :manufacturers_dvds
    drop_table :dvds_actors
  end
end
