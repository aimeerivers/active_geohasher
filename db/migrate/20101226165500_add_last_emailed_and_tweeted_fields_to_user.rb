class AddLastEmailedAndTweetedFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_emailed, :datetime
    add_column :users, :last_tweeted, :datetime
  end

  def self.down
    remove_column :users, :last_tweeted
    remove_column :users, :last_emailed
  end
end
