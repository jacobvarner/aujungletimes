class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :twitter

  def admin?
  	self.permission == "admin"
  end

  def writer?
  	self.permission == "writer"
  end

end
