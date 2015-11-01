class Discussion < ActiveRecord::Base
	has_many :replies, dependent: :destroy
	acts_as_votable

	extend FriendlyId
	friendly_id :title, use: :slugged
end
