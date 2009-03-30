class AddToUserLinks < ActiveRecord::Migration
  def self.up
    change_table :user_links do |t|
      t.integer :client_id
      t.decimal :lat
      t.decimal :long
    end
  end

  def self.down
    change_table :user_links do |t|
      t.remove :client_id, :lat,:long
    end
  end
end
