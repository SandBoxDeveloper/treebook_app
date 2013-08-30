require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
  user = User.new
  assert !user.save # user should not be saved in database
  assert !user.errors[:first_name].empty?
  end
  
  test "a user should enter a last name" do
  user = User.new
  assert !user.save 
  assert !user.errors[:last_name].empty?
  end
  
  test "a user should enter a profile name" do
  user = User.new
  assert !user.save 
  assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a unique profile name" do
  user = User.new
  user.profile_name = users(:sammy).profile_name
    
  assert !user.save
  assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a profile name without spaces" do
  	user = User.new(first_name: 'simon', last_name: 'john', email: 'sammy1@hotmail.co.uk')
  	user.password = user.password_confirmation = 'absnckldfj'
  	
  	user.profile_name = "My Profile With Spaces"
  	
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end
  
  test "a user can have a correctly formatted profile name" do
  	user = User.new(first_name: 'simon', last_name: 'john', email: 'sammy1@hotmail.co.uk')
  	user.password = user.password_confirmation = 'absnckldfj'
  	
  	user.profile_name = 'sammy01' # valid profile name containing letters, numbers, underscores and dashes.
  	assert user.valid?	
  end
  
  test "that no error is raised when trying to access a friend list" do
  	assert_nothing_raised do
  	  users(:sammy).friends
  	end
  end
  
  test "that creating friendships on a user works" do
    users(:sammy).friends << users(:mike) # add mike to sammy's list of friends
    users(:sammy).friends.reload
    assert users(:sammy).friends.include?(users(:mike)) # then checking to make sure sammy is still in the database after reloading it.
  end
  

  
end
