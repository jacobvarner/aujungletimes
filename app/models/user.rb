class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter

  # validates that username exists and is unique and makes sure Twitter usernames are unique
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :twitter, conditions: -> {where.not(twitter: nil)}

  def admin?
  	self.permission == "admin"
  end

  def writer?
  	self.permission == "writer"
  end

end
