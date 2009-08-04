class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.date :date
      t.integer :dow_id
      t.boolean :w30
      t.string :key
      t.string :md5
      t.decimal :lat, :precision => 16, :scale => 15
      t.decimal :lng, :precision => 16, :scale => 15
    end
  end

  def self.down
    drop_table :histories
  end
end

