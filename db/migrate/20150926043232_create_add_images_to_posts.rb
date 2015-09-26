class CreateAddImagesToPosts < ActiveRecord::Migration
  def up
  	remove_column :posts, :post_image
   	add_attachment :posts, :post_image
  end

  def down
  	remove_column :posts, :post_image
  	add_attachment :posts, :post_image
  end
end
