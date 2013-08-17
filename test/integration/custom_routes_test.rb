require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
	# login test
  test "that the /login route opens the login page" do
  	get '/login'
  	# want to make sure this response was successful
  	assert_response :success
  	end
  	
  	# logout test
  	test "that the /logout route opens the logout page" do
  	get '/logout'
  	assert_response :redirect
  	assert_redirected_to '/'
  	end
  	
  	# register test
  	test "that the /register route opens the register page" do
  	get '/register'
  	# want to make sure this response was successful
  	assert_response :success
  	end
  	
  	# make sure that a person's profile page can be 'GET'
  	test "that a profle page works" do
  		get '/sammy'
  		asseert_response :success
  	end
end
