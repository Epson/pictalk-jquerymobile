
user-login = !(email, password)->
	params = 
		"email": email,
		"password": password

	(res) <-! $.post "users/user-login", params
	res = JSON.parse res
	if res.err
		console.log "error occurs"

	else 
		console.log "login successful"
		jQuery.mobile.changePage("\#show-page");
do
	<-! $ document .on "click", "\#login-btn"
	email = $ '\#login-form input[name="email"]' .val!
	password = $ '\#login-form input[name="password"]' .val!
	user-login email, password