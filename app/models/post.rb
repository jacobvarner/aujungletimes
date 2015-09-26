class Post < ActiveRecord::Base
	include Bootsy::Container

	has_many :comments, dependent: :destroy
	validates :post_title, presence: true
end
