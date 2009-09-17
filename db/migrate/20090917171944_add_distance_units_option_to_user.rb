class AddDistanceUnitsOptionToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :distance_units, :string, :limit => 5, :default => 'miles'
  end

  def self.down
    remove_column :users, :distance_units
  end
end

