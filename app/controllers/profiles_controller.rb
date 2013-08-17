class ProfilesController < ApplicationController
  def show
  	# conditional logic
  	@user = User.find_by_profile_name(params[:id]) # trying to find user
  	if @user # if user profile name found
  		# assign statuses variable to statuses update
  		@statuses = @user.statuses.all
  		# render show template (show user profile)
  		render action: :show 
  		else # if no user profile is found
  		# way to tell rails something to send a not found response w/ render method
  		render file: 'public/404', status: 404, formats: [:html] # when a web browsers request html format, rails can't find anything
  															 	 # so send a not found page with the 404 status
  		end
  end
end
