class CreateChangeRefrerenceInReplies < ActiveRecord::Migration
  def change
   	rename_column :replies, :discussions_id, :discussion_id
  end
end
