require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)
  #pending
  should have_many(:pending_user_friendships)
  should have_many(:pending_friends)
  #requested
  should have_many(:requested_user_friendships)
  should have_many(:requested_friends)
  #blocked
  should have_many(:blocked_user_friendships)
  should have_many(:blocked_friends)

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
    users(:sammy).pending_friends << users(:mike) # add mike to sammy's list of friends
    users(:sammy).pending_friends.reload
    assert users(:sammy).pending_friends.include?(users(:mike)) # then checking to make sure sammy is still in the database after reloading it.
  end
  
  test "that calling to_param on a user returns the profile_name" do
    assert_equal "sammy", users(:sammy).to_param
  end

  context "#has_blocked?" do
    should "return true if a user has blocked another user" do
      assert users(:sammy).has_blocked?(users(:blocked_friend))
    end

    should "return false if a user has not blocked another user" do
      assert !users(:sammy).has_blocked?(users(:michael))
    end
  end
  
end
