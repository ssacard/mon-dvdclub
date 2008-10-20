class CreateBlockedUsers < ActiveRecord::Migration
  def self.up
    create_table :blocked_users do |t|
      t.integer :user_id
      t.integer :dvd_club_id
      t.integer :blocked_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :blocked_users
  end
end
