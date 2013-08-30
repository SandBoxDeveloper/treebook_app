require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  # make sure a user friendship belongs to a user and friend
  should belong_to(:user)
  should belong_to(:friend)
  
  test "that creating a friendship works" do
    assert_nothing_raised do # make sures no error or exceptions pop up inside this code block
      UserFriendship.create user: users(:sammy), friend: users(:mike)
    end
  end
  
  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:sammy).id, friend_id: users(:mike).id
    assert users(:sammy).friends.include?(users(:mike))
  end
end
