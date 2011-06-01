class AddPlayedToSong < ActiveRecord::Migration
  def self.up
    add_column :twitterfeeds, :played, :boolean, :default => 0 
  end

  def self.down
    remove_column :twitterfeeds, :played
  end
end
