class DropTableClubTopics < ActiveRecord::Migration
  def self.up
    drop_table :club_topics
  end

  def self.down
  create_table :club_topics do |t|
    t.string :name
  end
  end
end
