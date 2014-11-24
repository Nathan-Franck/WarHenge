class exports.DocumentLoop extends System
	update: () ->
	constructor: (@update) ->
		document.addEventListener(
			"focus" 
			() -> 
				@mainLoop()
			true
		)
		@mainLoop()
	mainLoop: () ->
		@update()
		if document.hasFocus()
			requestAnimationFrame(@mainLoop)