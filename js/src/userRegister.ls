
user-register = !(email, password)->
	params = 
		"email": email,
		"password": password

	(res) <-! $.post "users/user-register", params
	res = JSON.parse res
	if res.err
		console.log "error occurs"
	else 
		console.log "register successful"
do
	<-! $ document .on "click", "\#register-btn"
	email = $ '\#login-form input[name="email"]' .val!
	password = $ '\#login-form input[name="password"]' .val!
	user-register email, password