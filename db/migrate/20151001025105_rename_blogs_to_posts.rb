class RenameBlogsToPosts < ActiveRecord::Migration
  def change
  	rename_table :blogs, :posts
  	rename_column :comments, :blog_id, :post_id
  end
end
