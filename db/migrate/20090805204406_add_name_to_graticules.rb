class AddNameToGraticules < ActiveRecord::Migration
  def self.up
    add_column :graticules, :name, :string
  end

  def self.down
    remove_column :graticules, :name
  end
end
