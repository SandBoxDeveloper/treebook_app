require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:sammy).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end
  
  # to make sure if someone's profile isn't found, there is a response saying 'user not found' as a 404 page (page not found)
  test "should render a 404 on profile not found" do
  	get :show, id: "doesn't exist"
  	assert_response :not_found
  end
  
  # test to correctly assign variables when show page is displayed
  test "that variables are assigned on successful profile viewing" do
  	get :show, id: users(:sammy).profile_name
  	assert assigns(:user) # assigns makes sure that instance vairables and controllers are proberly set
  	assert_not_empty assigns(:statuses) # to make sure statuses are set as well, making sure array has one or more items.
  end
  
  # to make sure only the correct statuses are show for a particular user
  test "only shows the correct user's statuses" do
  	get :show, id: users(:sammy).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:sammy), status.user
  	end
  end

end
