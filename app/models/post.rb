class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_attached_file :post_image, styles: { large: "600x400>", medium: "300x200>", small: "150x100#"}
	validates_attachment_content_type :post_image, content_type: /\Aimage\/.*\Z/

	extend FriendlyId
	friendly_id :post_title, use: :slugged

	validates_uniqueness_of :post_title

end
