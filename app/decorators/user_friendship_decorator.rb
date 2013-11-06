class UserFriendshipDecorator < Draper::Decorator
  decorates :user_friendship #if a certain method doesnt exits in the user friendship decorator, go and try it on the model that it inherites from
  delegate_all

  def friendship_state
  	model.state.titleize
  end

  def sub_message
  	case model.state
  	when 'pending'
  		"Friend request is pending."
  	when 'accepted'
  		"You are friends with #{model.friend.first_name}."
  	end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
