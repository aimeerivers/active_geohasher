class CreateGraticules < ActiveRecord::Migration
  def self.up
    create_table :graticules do |t|
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :graticules
  end
end
