
Controller = 
	user-update-mobile: !(mobile)->
		User.update-mobile User.user-id, mobile

	upload-avatar: !(form-file-obj)->
		data = new FormData!
		files = ($ "\#upload-file")[0].files
		if files?
			data.append "avatarFile", files[0]
		params = 
			cache: false,
			type: 'post',
			dataType: 'json',
			url:'users/user-upload-avatar',
			data: data,
			contentType: false,
			processData: false,
			success: !(res)->
				console.log "res"

		$.ajax params

	user-update-avatar: !(avatar-url)->

	user-login: !(email, password)->
		User.login email, password

	user-logout: !->
		User.logout!

	user-register: !(email, password)->
		User.register email, password

	get-friend-list: !->
		Friend.read-friend-list User.user-id

	show-friend-list: !(friend-list-array)->
		Event-center.trigger "Viewer:show-friend-list", [friend-list-array]

	add-friend: !(friend-id)->
		console.log "Controller:add-friend"
		Friend.add-friend User.user-id, friend-id
		# Friend.add-friend "121927532@qq.com", "aaa@qq.com"

	get-friend-info: !(friend-id)->
		Friend.get-friend-info friend-id

	show-friend-info: !(friend-info)->
		Event-center.trigger "Viewer:show-friend-info", [friend-info]

	subscribe-events: !->
		Event-center.bind "Controller:user-update-avatar", Event-center.proxy this.upload-avatar, this
		Event-center.bind "Controller:user-update-mobile", Event-center.proxy this.user-update-mobile, this
		Event-center.bind "Controller:user-login", Event-center.proxy this.user-login, this
		Event-center.bind "Controller:user-logout", Event-center.proxy this.user-logout, this
		Event-center.bind "Controller:user-register", Event-center.proxy this.user-register, this
		Event-center.bind "Controller:get-friend-list", Event-center.proxy this.get-friend-list, this
		Event-center.bind "Controller:show-friend-list", Event-center.proxy this.show-friend-list, this
		Event-center.bind "Controller:get-friend-info", Event-center.proxy this.get-friend-info, this
		Event-center.bind "Controller:show-friend-info", Event-center.proxy this.show-friend-info, this



	init: !->
		@subscribe-events!
		console.log "Controller-init"
		# @add-friend "121927532@qq.com", "aaa@qq.com"


window.Controller = Controller