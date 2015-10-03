class Discussion < ActiveRecord::Base
	has_many :replies, dependent: :destroy
	acts_as_votable

	extend FriendlyId
	friendly_id :title, use: :slugged

	validates_uniqueness_of :title
	validates_format_of :link, :with => URI.regexp(['http', 'https'])
end
