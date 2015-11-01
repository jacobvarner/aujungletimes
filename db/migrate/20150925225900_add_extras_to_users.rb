class AddExtrasToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :twitter, :string
  	add_column :users, :permission, :string, default: 'user'
  	add_column :users, :join_date, :datetime, default: Time.now
  end
end
