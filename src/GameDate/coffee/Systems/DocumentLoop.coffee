class exports.DocumentLoop extends System
	constructor: (@func) ->
		document.addEventListener(
			"focus" 
			() -> 
				mainLoop()
			true
		)
		@mainLoop()
	mainLoop: () ->
		@func()
		if document.hasFocus()
			requestAnimationFrame(@mainLoop)