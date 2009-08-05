class AlterCoordinateAccuracy < ActiveRecord::Migration
  def self.up
    change_column :geohashes, :lat, :decimal, :precision => 23, :scale => 19
    change_column :geohashes, :lng, :decimal, :precision => 23, :scale => 19
    change_column :histories, :lat, :decimal, :precision => 20, :scale => 19
    change_column :histories, :lng, :decimal, :precision => 20, :scale => 19
  end

  def self.down
    change_column :geohashes, :lat, :decimal, :precision => 20, :scale => 15
    change_column :geohashes, :lng, :decimal, :precision => 20, :scale => 15
    change_column :histories, :lat, :decimal, :precision => 16, :scale => 15
    change_column :histories, :lng, :decimal, :precision => 16, :scale => 15
  end
end

