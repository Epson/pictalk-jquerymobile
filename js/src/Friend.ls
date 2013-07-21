
Friend = 
	read-friend-list: !(user-id)->
		params = 
			user-id: user-id
		(res) <-! $.get "friends/read-friend-list", params
		res = JSON.parse res
		Event-center.trigger "Controller:show-friend-list", [res.friends]

	add-friend: !(user-id, friend-id)->
		console.log "Friend:add-friend"
		params = 
			user-id: user-id,
			friend-id: friend-id
		console.log params
		(res) <-! $.post "friends/create-friend", params
		res = JSON.parse res
		console.log res

	init: !->
		console.log "Friend init" 

window.Friend = Friend


	