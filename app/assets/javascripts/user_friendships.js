// load entire friends list
window.userFriendships = [];

$(document).ready(function() {
	$.ajax({
		url: Routes.user_friendships_path({format: 'json'}),
		dataType: 'json',
		type: 'GET',
		success: function(data) {
			window.userFriendships = data;
		}
	});

	$('#add-friendship').click(function(event) {
		event.preventDefault(); // prevents deault behaviour when the event button is clicked
		var addFriendshipBtn = $(this);
		// post to the user friendship path as if we where he user itself
		$.ajax({
			url: Routes.user_friendships_path({user_friendship: { friend_id: addFriendshipBtn.data('friendId') }}),
			dataType: 'json',
			type: 'POST',
			success: function(e) {
				addFriendshipBtn.hide();
				$('#friend-status').html("<a href='#'' class='btn btn-success'>Friendship Requested</a>");
			}
		});
	});

});
