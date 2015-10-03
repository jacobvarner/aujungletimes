class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	extend FriendlyId
	friendly_id :post_title, use: :slugged

	validates_uniqueness_of :post_title

end
