class exports.DocumentLoop extends System
	constructor: (@update) ->
		document.addEventListener(
			"onfocus" 
			@mainLoop()
			true
		)
		@mainLoop()
	mainLoop: () =>
		@update()
		if document.hasFocus()
			requestAnimationFrame(@mainLoop)