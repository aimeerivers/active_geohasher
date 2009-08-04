class CreateDows < ActiveRecord::Migration
  def self.up
    create_table :dows do |t|
      t.date :date
      t.decimal :dow, :precision => 10, :scale => 2
    end
  end

  def self.down
    drop_table :dows
  end
end

