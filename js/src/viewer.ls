
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
		page-width = screen-width * 0.3
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

	subscrbe-events: !->
		console.log "subscrbe-events"

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
			
 
window.Viewer = Viewer
