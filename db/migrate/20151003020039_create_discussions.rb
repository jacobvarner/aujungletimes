class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
    	t.string :title, null: false
    	t.string :link
    	t.text :content, null: false
    	t.string :creator
    	t.string :category
    	t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
