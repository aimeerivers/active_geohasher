class AddLatLngFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :lat, :decimal, :precision => 23, :scale => 19
    add_column :users, :lng, :decimal, :precision => 23, :scale => 19
  end

  def self.down
    remove_column :users, :lng
    remove_column :users, :lat
  end
end
