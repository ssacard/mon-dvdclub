class RemoveClubTopicIdFromDvdClub < ActiveRecord::Migration
  def self.up
    remove_column :dvd_clubs, :club_topic_id
  end

  def self.down
    add_column :dvd_clubs, :club_topic_id, :integer
  end
end
