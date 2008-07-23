class RemoveDvdClubIdFromDvds < ActiveRecord::Migration
  def self.up
    remove_column :dvds, :dvd_club_id
  end

  def self.down
    add_column :dvds, :dvd_club_id, :integer
  end
end
