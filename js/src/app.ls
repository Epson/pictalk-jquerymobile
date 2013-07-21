
app = 
	init: !->
		Viewer.init!
		Controller.init!

app.init!

window.app = app;