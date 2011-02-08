class RemoveDescriptionFromDvdClub < ActiveRecord::Migration
  def self.up
    remove_column :dvd_clubs, :description
  end

  def self.down
    add_column :dvd_clubs, :description, :text
  end
end
