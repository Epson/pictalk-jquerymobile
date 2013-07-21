
Viewer =
	# loadStyleFile: !(fileName) ->
	# 	fileref = document.createElement "link"
	# 	fileref.rel = "stylesheet"
	# 	fileref.type = "text/css"
	# 	fileref.href = "css/src/" + fileName + ".css"
	# 	fileref.media = "screen"
	# 	headobj = document.getElementsByTagName("head")[0]
	# 	headobj.appendChild fileref

	is-text-selected: false,

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
								"<a href='\#friend-info-page'>" + 
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

	show-friend-info: !(friend-info)->
		user-id = friend-info.user-id
		username = friend-info.username
		email = friend-info.email
		if friend-info.mobile?
			mobile = friend-info.mobile
		else
			mobile = "未填写"
		user-info-list = $ "\#user-info-list"
		user-info-str = "<li>" +
											"<span style='width:40%;display:inline-block;'>用户ID</span>" +
											"<span style='color:gray;'>" + user-id + "</span>" +
										"</li>" +
										"<li>" +
											"<span style='width:40%;display:inline-block;'>用户名</span>" +
											"<span style='color:gray;'>" + username + "</span>" +
										"</li>" +
										"<li>" +
											"<span style='width:40%;display:inline-block;'>性别</span>" +
											"<span style='color:gray;'>男</span>" +
										"</li>" +
										"<li>" +
											"<span style='width:40%;display:inline-block;'>电话号码</span>" +
											"<span style='color:gray;'>" + mobile + "</span>" +
										"</li>" +
										"<li>" +
											"<span style='width:40%;display:inline-block;'>电子邮件</span>" +
											"<span style='color:gray;'>" + email + "</span>" +
										"</li>"
		user-info-list.html user-info-str
		user-info-list.listview "refresh" 

	set-picture-size: !(img, container)->
		page = $("\#new-message-page")
		img-width = container.scroll-width
		img-height = container.scroll-height
		header-height = page.find(".header").height!
		footer-height = page.find(".footer").height!
		screen-width = container.client-width
		screen-height = window.inner-height - header-height - footer-height
		console.log "window.inner-height：" + window.inner-height
		if img-width < img-height
			new-img-width = parseInt screen-width
			new-img-height = parseInt(img-height * ( new-img-width / img-width ) )
			console.log "keep width"
			console.log "new-img-width: " + new-img-width
			console.log "new-img-height: " + new-img-height
		else 
			new-img-height = parseInt screen-height
			new-img-width = parseInt(img-width * ( new-img-height / img-height ))
			console.log "keep height"
			console.log "new-img-width: " + new-img-width
			console.log "new-img-height: " + new-img-height
		img.style.width = new-img-width + "px"
		img.style.height = new-img-height + "px"
		console.log "img-width: " + img-width
		console.log "img-height: " + img-height
		console.log "header-height: " + header-height
		console.log "footer-height: " + footer-height
		console.log "screen-width: " + screen-width
		console.log "screen-height: " + screen-height
		
	show-new-picture: !(files)->
		self = this
		picture-container = $("\#create-picture");
		picture-container.html ""
		for i from 0 til files.length
			file = files[0]
			reader = new FileReader!
			reader.onload = !(e)->
				img-data = e.target.result
				img = document.createElement "img"
				img.src = img-data
				img.id = "picture"
				picture-container.html img
				self.set-picture-size img, picture-container[0]
			reader.readAsDataURL file

	add-text-icon: !(picture, x, y)->
		img = document.createElement("img")
		img.src = "images/text_tip.png"
		img.id = "text-icon"
		pic-pos-x = picture.offset-left
		pic-pos-y = picture.offset-top
		img.style.left = (pic-pos-x + x) + "px"
		img.style.top = (pic-pos-y + y) + "px"
		img.style.width = "50px"
		img.style.height = "50px"
		picture.parentNode.appendChild img

	add-text: !(picture, x, y)->
		console.log picture
		@add-text-icon picture, x, y

	subscrbe-events: !->
		Event-center.bind "Viewer:show-friend-list", Event-center.proxy this.show-friend-list, this
		Event-center.bind "Viewer:show-friend-info", Event-center.proxy this.show-friend-info, this
		Event-center.bind "Viewer:show-new-picture", Event-center.proxy this.show-new-picture, this

	bind-events: !->
		self = this

		# change avatar
		do
			<-! $(document).on "click", "\#changeAvatar"
			$("\#upload-file") .click!

		#upload-avatar
		do 
			<-! $(document).on "change", "\#upload-file"
			avatar = $("\#upload-file")[0]
			Event-center.trigger "Controller:user-update-avatar", [avatar.files[0]]
			
		# change mobile
		do
			(e) <-! $(document).on "click", "\#change-mobile-confirm-btn-wrapper"
			mobile = $("input[name='mobile']").val!
			Event-center.trigger "Controller:user-update-mobile", [mobile]
			
		# user login
		do
			(e) <-! $(document).on "click", "\#login-btn"
			email = $("\#login-form input[name='email']").val!
			password = $("\#login-form input[name='password']").val!
			Event-center.trigger "Controller:user-login", [email, password]

		do
			(e) <-! $(document).on "click", "\#logout-confirm-button"
			Event-center.trigger "Controller:user-logout"

		# user register
		do
			(e) <-! $(document).on "click", "\#register-btn"
			email = $("\#register-form input[name='email']").val!
			password = $("\#register-form input[name='password']").val!
			Event-center.trigger "Controller:user-register", [email, password]

		# read-friend-list
		do 
			(e) <-! $(document).on "click", "a[href='\#contact-page']"
			Event-center.trigger "Controller:get-friend-list"

		# read-friend-info
		do 
			(e) <-! $(document).on "click", ".contact-info"
			user-id = $(".contact-email").html!
			Event-center.trigger "Controller:get-friend-info", [user-id]

		# create-picture
		do
			(e) <-! $(document).on "click", ".new-picture"
			$("\#new-picture").click!

		# upload-avatar
		do 
			(e) <-! $(document).on "change", "\#new-picture"
			files = this.files
			Event-center.trigger "Viewer:show-new-picture" [files]

		# select text
		do
			(e) <-! $(document).on "click", ".add-text"
			self.is-text-selected = true
			console.log "select text"

		do
			(e) <-! $(document).on "click", "\#picture"
			console.log self.is-text-selected
			if self.is-text-selected?
				elem = e.target
				pos-x = e.offsetX 
				pos-y = e.offsetY
				self.add-text this, pos-x, pos-y

		do
			(e) <-! $(document).on "scroll", "\#create-picture"
			console.log this.scroll-left

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
		$.mobile.fixedtoolbar.prototype.options.tapToggle = false;
 
window.Viewer = Viewer
