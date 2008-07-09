class ModifyDvdModel < ActiveRecord::Migration
  def self.up
    remove_column :dvds, :subscription_status
    add_column :dvds, :state, :string
    add_column :dvds, :booked_by, :integer
  end

  def self.down
    add_column :dvds, :subscription_status, :string
    remove_column :dvds, :state
  end
end
