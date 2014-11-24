class exports.DocumentLoop extends System
	constructor: (@func) ->
		document.addEventListener(
			"focus" 
			() -> 
				mainLoop()
			true
		)
		@mainLoop()
	mainLoop: () ->exports.
		@func()
		if document.hasFocus()
			requestAnimationFrame(@mainLoop)