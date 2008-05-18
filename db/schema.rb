# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "actors", :force => true do |t|
    t.string "name"
  end

  create_table "amazon_stores", :force => true do |t|
  end

  create_table "directors", :force => true do |t|
    t.string "name"
  end

  create_table "directors_dvds", :id => false, :force => true do |t|
    t.integer "director_id"
    t.integer "dvd_id"
  end

  add_index "directors_dvds", ["dvd_id"], :name => "directors_has_dvds_FKIndex2"
  add_index "directors_dvds", ["director_id"], :name => "directors_has_dvds_FKIndex1"

  create_table "dvds", :force => true do |t|
    t.string "asin"
    t.text   "details_url"
    t.string "title"
  end

  create_table "dvds_actors", :id => false, :force => true do |t|
    t.integer "actor_id"
    t.integer "dvd_id"
  end

  add_index "dvds_actors", ["actor_id"], :name => "dvds_has_actors_FKIndex2"
  add_index "dvds_actors", ["dvd_id"], :name => "dvds_has_actors_FKIndex1"

  create_table "manufacturers", :force => true do |t|
    t.string "name"
  end

  create_table "manufacturers_dvds", :id => false, :force => true do |t|
    t.integer "manufacturer_id"
    t.integer "dvd_id"
  end

  add_index "manufacturers_dvds", ["dvd_id"], :name => "manufacturers_has_dvds_FKIndex2"
  add_index "manufacturers_dvds", ["manufacturer_id"], :name => "manufacturers_has_dvds_FKIndex1"

end
