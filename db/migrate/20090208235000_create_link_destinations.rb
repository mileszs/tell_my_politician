class CreateLinkDestinations < ActiveRecord::Migration
  def self.up
    create_table :link_destinations do |t|
      t.integer :id
      t.string :sl_id
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :link_destinations
  end
end
