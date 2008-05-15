class DvdModel < ActiveRecord::Migration
  def self.up
  create_table "actors", :force => true do |t|
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

  create_table "dvds", :force => true do |t|
    t.string "asin"
    t.text   "details_url"
    t.string "title"
  end

  create_table "dvds_actors", :id => false, :force => true do |t|
    t.integer "actor_id"
    t.integer "dvd_id"
  end

  add_index "dvds_actors", ["dvd_id"], :name => "dvds_has_actors_FKIndex1"
  add_index "dvds_actors", ["actor_id"], :name => "dvds_has_actors_FKIndex2"

  create_table "manufacturers", :force => true do |t|
    t.string "name"
  end

  create_table "manufacturers_dvds", :id => false, :force => true do |t|
    t.integer "manufacturer_id"
    t.integer "dvd_id"
  end

  add_index "manufacturers_dvds", ["manufacturer_id"], :name => "manufacturers_has_dvds_FKIndex1"
  add_index "manufacturers_dvds", ["dvd_id"], :name => "manufacturers_has_dvds_FKIndex2"

  create_table "amazon_stores", :force => true do |t|
  end

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
