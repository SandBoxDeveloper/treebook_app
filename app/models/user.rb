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
  has_many :user_friendships
  #pending
  has_many :friends, through: :user_friendships,
                     conditions: {user_friendships: { state: 'accepted' }}
                     
  has_many :pending_user_friendships, class_name: 'UserFriendship', 
  									  foreign_key: :user_id,
  									  conditions: { state: 'pending' }  
  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  #requested
  has_many :requested_user_friendships, class_name: 'UserFriendship', 
                      foreign_key: :user_id,
                      conditions: { state: 'requested' }  
  has_many :requested_friends, through: :pending_user_friendships, source: :friend 

  #blocked
  has_many :blocked_user_friendships, class_name: 'UserFriendship', 
                      foreign_key: :user_id,
                      conditions: { state: 'blocked' }  
  has_many :blocked_friends, through: :pending_user_friendships, source: :friend 

  #accepted
  has_many :accepted_user_friendships, class_name: 'UserFriendship', 
                      foreign_key: :user_id,
                      conditions: { state: 'accepted' }  
  has_many :accepted_friends, through: :pending_user_friendships, source: :friend 		

  #pending
  has_many :pending_user_friendships, class_name: 'UserFriendship', 
                      foreign_key: :user_id,
                      conditions: { state: 'pending' }  
  has_many :pending_friends, through: :pending_user_friendships, source: :friend							                  
  
  def full_name
  	first_name + " " + last_name
  end
  
  def to_param
    profile_name
  end
  
  def gravatar_url
  	stripped_email = email.strip # removes any spaces before or after text
  	downcased_email = stripped_email.downcase # turn text into all lowercase
  	hash = Digest::MD5.hexdigest(downcased_email) # creates hash formate of email
  	
  	"http://gravatar.com/avatar/#{hash}" # return gravatar url
  end

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end
end
