class CreateYoutubevideos < ActiveRecord::Migration
  def self.up
    create_table :youtubevideos do |t|
      t.string :title
      t.string :url
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :youtubevideos
  end
end
