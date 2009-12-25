class MoveDistanceUnitsToPreferences < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      user.preferred_distance_units = user.distance_units
      user.save
    end
    remove_column :users, :distance_units
  end

  def self.down
    add_column :users, :distance_units, :string, :limit => 5, :default => 'miles'
    User.all.each do |user|
      user.distance_units = user.preferred_distance_units
      user.save
    end
  end
end
