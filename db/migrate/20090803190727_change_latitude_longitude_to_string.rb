class ChangeLatitudeLongitudeToString < ActiveRecord::Migration
  def self.up
    change_column :graticules, :latitude, :string, :limit => 3
    change_column :graticules, :longitude, :string, :limit => 4
  end

  def self.down
    change_column :graticules, :latitude, :integer
    change_column :graticules, :longitude, :integer
  end
end
