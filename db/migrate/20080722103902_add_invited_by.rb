class AddInvitedBy < ActiveRecord::Migration
  def self.up
    change_table :user_dvd_clubs do |t|
      t.integer :invited_by_id 
    end
  end

  def self.down
    change_table :user_dvd_clubs do |t|
      t.remove :invited_by_id 
    end
  end
end
