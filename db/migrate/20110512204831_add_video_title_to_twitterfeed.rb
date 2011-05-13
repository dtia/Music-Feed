class AddVideoTitleToTwitterfeed < ActiveRecord::Migration
  def self.up
    add_column :twitterfeeds, :title, :string
  end

  def self.down
    remove_column :twitterfeeds, :title
  end
end
