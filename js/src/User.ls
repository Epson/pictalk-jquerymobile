
User = 
	user-id: undefined,

	update-mobile: !(user-id, mobile)->
		params = 
			user-id: user-id,
			mobile: mobile
		(res) <-! $.post "users/user-info-update", params
		console.log res

	login: !(email, password)->
		self = this
		params =
			email: email,
			password: password
		(res) <-! $.post "users/user-login", params
		if !res.err?
			console.log "login successful"
			self.user-id = email
			jQuery.mobile.changePage("\#show-page");
		else 
			console.log "error occurs"

	logout: !->
		this.user-id = undefined;
		jQuery.mobile.changePage("\#index-page");

	register: !(email, password)->
		self = this
		params = 
			email: email,
			password: password
		(res) <-! $.post "users/user-register", params
		if !res.err?
			console.log "register successful"
			self.user-id = email
			jQuery.mobile.changePage("\#show-page");
		else 
			console.log "error occurs"

	init: !->
		console.log "init" 

window.User = User


	