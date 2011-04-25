class AddTestData < ActiveRecord::Migration
  def self.up
	Product.delete_all
	Product.create(:title => 'Harry Potter and the Sorcerer\'s Stone',
		:description => %{<p> This is the first book in the Harry Potter series </p>},
		:image_url => '/images/svn.jpg',
		:price => 28.50)
  end

  def self.down
	Product.delete_all
  end
end
