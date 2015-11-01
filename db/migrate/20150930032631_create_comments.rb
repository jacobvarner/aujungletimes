class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :username
      t.text :body
      t.references :blog, index: true

      t.timestamps null: false
    end
  end
end
