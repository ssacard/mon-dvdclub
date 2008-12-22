class CreateBlacklistings < ActiveRecord::Migration
  def self.up
    create_table :blacklistings do |t|
      t.integer :user_id
      t.integer :user_id_target
      t.boolean :source_forgot
      t.boolean :target_forgot

      t.timestamps
    end
  end

  def self.down
    drop_table :blacklistings
  end
end
