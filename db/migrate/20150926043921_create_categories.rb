class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string :category_title
    	t.boolean :blog, default: true

      t.timestamps null: false
    end
  end
end
