class CreateUserLinks < ActiveRecord::Migration
  def self.up
    create_table :user_links do |t|
      t.integer :id
      t.string :ip
      t.integer :link_id
      t.integer :linkdestination_id
      t.integer :destination_status

      t.timestamps
    end
  end

  def self.down
    drop_table :user_links
  end
end
