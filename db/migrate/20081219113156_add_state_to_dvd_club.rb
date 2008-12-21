class AddStateToDvdClub < ActiveRecord::Migration
  def self.up
    add_column :dvd_clubs, :state, :string
  end

  def self.down
    remove_column :dvd_clubs, :state
  end
end
