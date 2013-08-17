class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  					:first_name, :last_name, :profile_name
  # attr_accessible :title, :body
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
  						   uniqueness: true,
  						   format: {
  						   	with: /^[a-zA-Z0-9_-]+$/, # ^, has to match the first part and the last part. [], can be anyone of these characters. +, specifies that your going to need more than one character there.
  						   	message: 'Must be formatted correctly.'
  						   }
  
  has_many :statuses
  
  def full_name
  	first_name + " " + last_name
  end
  
  def gravatar_url
  	stripped_email = email.strip # removes any spaces before or after text
  	downcased_email = stripped_email.downcase # turn text into all lowercase
  	hash = Digest::MD5.hexdigest(downcased_email) # creates hash formate of email
  	
  	"http://gravatar.com/avatar/#{hash}" # return gravatar url
  end
end
