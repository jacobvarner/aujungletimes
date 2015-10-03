class CreateAddSlugToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :slug, :string, uniq: true
  end
end
