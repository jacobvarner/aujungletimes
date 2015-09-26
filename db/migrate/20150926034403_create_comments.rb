class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :username
      t.text :body
      t.datetime :date_created
      t.datetime :date_edited
      t.references :post

      t.timestamps null: false
    end
  end
end
