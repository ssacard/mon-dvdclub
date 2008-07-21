class AddInvitationsForDvdClubs < ActiveRecord::Migration
  def self.up
    create_table "invitations", :force => true do |t|
      t.integer :dvd_club_id
      t.integer :user_id
      t.string  :token
      t.string  :email
      t.boolean :active
      t.timestamps
    end
    
    add_column :user_dvd_clubs, :comments, :text
  end

  def self.down
    drop_table :invitations
    remove_column :user_dvd_clubs, :comments
  end
end
