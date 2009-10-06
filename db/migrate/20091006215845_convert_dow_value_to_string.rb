class ConvertDowValueToString < ActiveRecord::Migration
  def self.up
    change_column :dows, :dow, :string, :limit => 10
  end

  def self.down
    change_column :dows, :dow, :decimal, :precision => 10, :scale => 2
  end
end

