class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :post_title, null: false
    	t.string :post_author, null: false
    	t.text :post_description, default: "No Description"
    	t.text :post_content
    	t.string :post_image
    	t.string :category
    	t.datetime :date_created
    	t.datetime :date_edited
      t.boolean :publish, default: false


      t.timestamps null: false
    end
  end
end
