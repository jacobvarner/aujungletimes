class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
    	t.string :username
      t.text :body
      t.references :discussions, index: true

      t.timestamps null: false
    end
  end
end
