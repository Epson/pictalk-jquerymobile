
loadStyleFile = !(fileName) ->
	fileref = document.createElement "link"
	fileref.rel = "stylesheet"
	fileref.type = "text/css"
	fileref.href = "css/src/" + fileName + ".css"
	fileref.media = "screen"
	headobj = document.getElementsByTagName("head")[0]
	headobj.appendChild fileref

initMobileStyle = !->
	width = screen.availWidth	
	height = screen.availHeight

	indexContent = document.getElementById "index-content"
	indexContent.style.width = width - 20 + "px"
	indexContent.style.height = height - 30 + "px"



do
	<-! $(document).bind "mobileinit"
	$.mobile.page.prototype.options.addBackBtn = true