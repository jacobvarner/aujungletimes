class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|

      t.string :post_title, null: false
      t.string :post_author, null: false
      t.text :post_description, default: "No Description"
      t.text :post_content
      t.string :post_image
      t.string :post_category
      t.boolean :publish, default: false

      t.timestamps null: false
    end
  end
end
