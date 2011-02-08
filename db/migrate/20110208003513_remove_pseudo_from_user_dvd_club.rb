class RemovePseudoFromUserDvdClub < ActiveRecord::Migration
  def self.up
    remove_column :user_dvd_clubs, :pseudo
  end

  def self.down
    add_column :user_dvd_clubs, :pseudo, :string
  end
end
