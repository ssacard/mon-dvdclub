class AddBookedAt < ActiveRecord::Migration
  def self.up
    add_column :dvds, :booked_at, :datetime
  end

  def self.down
    remove_column :dvds, :booked_at
  end
end
