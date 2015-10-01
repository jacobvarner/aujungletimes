class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	extend FriendlyId
	friendly_id :post_title, use: :slugged

end
