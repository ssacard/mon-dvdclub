class AddFacebookIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_id, :string
  end

  def self.down
    remove_column :users, :facebook_id
  end
end
