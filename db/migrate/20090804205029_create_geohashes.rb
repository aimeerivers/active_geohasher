class CreateGeohashes < ActiveRecord::Migration
  def self.up
    create_table :geohashes do |t|
      t.integer :graticule_id
      t.integer :history_id
      t.date :date
      t.string :place_name
      t.decimal :lat, :precision => 20, :scale => 15
      t.decimal :lng, :precision => 20, :scale => 15

      t.timestamps
    end
  end

  def self.down
    drop_table :geohashes
  end
end

