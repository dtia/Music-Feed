class AddYoutubeVideoToTwitterfeed < ActiveRecord::Migration
  def self.up
    add_column :twitterfeeds, :video, :string
  end

  def self.down
    remove_column :twitterfeeds, :video
  end
end
