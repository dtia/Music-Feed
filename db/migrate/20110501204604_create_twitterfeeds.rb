class CreateTwitterfeeds < ActiveRecord::Migration
  def self.up
    create_table :twitterfeeds do |t|
      t.string :text
      t.string :user

      t.timestamps
    end
  end

  def self.down
    drop_table :twitterfeeds
  end
end
