
Viewer =
	# loadStyleFile: !(fileName) ->
	# 	fileref = document.createElement "link"
	# 	fileref.rel = "stylesheet"
	# 	fileref.type = "text/css"
	# 	fileref.href = "css/src/" + fileName + ".css"
	# 	fileref.media = "screen"
	# 	headobj = document.getElementsByTagName("head")[0]
	# 	headobj.appendChild fileref

	init-mobile-style: !->
		width = screen.availWidth	
		height = screen.availHeight

		indexContent = document.getElementById "index-content"
		indexContent.style.width = width - 20 + "px"
		indexContent.style.height = height - 30 + "px"

	init-pc-style: !->
		screen-width = document.body.client-width
		pages = document.getElementsByClassName("page");
		headers = document.getElementsByClassName("header");
		footers = document.getElementsByClassName("footer");
		page-width = screen-width * 0.35
		for i from 0 til pages.length
			pages[i].style.width = page-width + "px"
			pages[i].style.left = screen-width * 0.5
			pages[i].style.marginLeft = -(page-width / 2) + "px"
		for i from 0 til headers.length
			headers[i].style.width = page-width + "px"
			headers[i].style.left = screen-width * 0.5
			headers[i].style.marginLeft = -(page-width / 2) + "px"
		for i from 0 til footers.length
			footers[i].style.width = page-width + "px"
			footers[i].style.left = screen-width * 0.5
			footers[i].style.marginLeft = -(page-width / 2) + "px"

	show-friend-list: !(friend-list-array)->
		length = friend-list-array.length
		contact-list = $ "\#contact-list"
		contact-list.html ""
		for i from 0 til length
			li = $ "<li class='contact-info'>" + 
								"<a href='javascript:void(0);'>" + 
									"<img src='images/1.jpeg'/>" +
									"<span class='contact-name'>" + 
										friend-list-array[i].username + 
									"</span> <br/> <br />" +
									"<span class='contact-email'>" + 
										friend-list-array[i].user-id + 
									"</span>" +
								"</a></li>";
			contact-list.append li
		contact-list.listview "refresh" 

	subscrbe-events: !->
		Event-center.bind "Viewer:show-friend-list", Event-center.proxy this.show-friend-list, this

	bind-events: !->
		# change avatar
		do
			<-! ($ document).on "click", "\#changeAvatar"
			($ "\#upload-file") .click!

		#upload-avatar
		do 
			<-! ($ document).on "change", "\#upload-file"
			avatar = ($ "\#upload-file")[0]
			Event-center.trigger "Controller:user-update-avatar", [avatar.files[0]]
			
		# change mobile
		do
			(e) <-! ($ document).on "click", "\#change-mobile-confirm-btn-wrapper"
			mobile = $("input[name='mobile']").val!
			Event-center.trigger "Controller:user-update-mobile", [mobile]
			
		# user login
		do
			(e) <-! ($ document).on "click", "\#login-btn"
			email = $("\#login-form input[name='email']").val!
			password = $("\#login-form input[name='password']").val!
			Event-center.trigger "Controller:user-login", [email, password]

		do
			(e) <-! ($ document).on "click", "\#logout-confirm-button"
			Event-center.trigger "Controller:user-logout"

		# user register
		do
			(e) <-! ($ document).on "click", "\#register-btn"
			email = $("\#register-form input[name='email']").val!
			password = $("\#register-form input[name='password']").val!
			Event-center.trigger "Controller:user-register", [email, password]

		# read-friend-list
		do 
			(e) <-! ($ document).on "click", "a[href='\#contact-page']"
			Event-center.trigger "Controller:get-friend-list"

		# read-friend-info
		do 
			(e) <-! ($ document).on "click", ".contact-info"
			user-id = $(".contact-email")
			Event-center.trigger "Controller:get-friend-info", [user-id]

	init: !->
		if( (navigator.userAgent.match(/iPad/i)) || (navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i))) 
			# Apple-device?
			@init-mobile-style!
		else if(navigator.userAgent.match(/Android/i)) 
			#Android-device?
			@init-mobile-style!
		else
			#PC
			@init-pc-style!

		@subscrbe-events!
		@bind-events!
			
 
window.Viewer = Viewer
