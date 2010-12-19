class CreateFails < ActiveRecord::Migration
  def self.up
    create_table :fails do |t|
      t.string :klass
      t.string :message
      t.text :backtrace

      t.timestamps
    end
  end

  def self.down
    drop_table :fails
  end
end
