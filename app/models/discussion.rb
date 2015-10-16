class Discussion < ActiveRecord::Base
	has_many :replies, dependent: :destroy
	acts_as_votable

	extend FriendlyId
	friendly_id :title, use: :slugged

	validates :link, :url => {allow_blank => true, allow_nil => true}
end
