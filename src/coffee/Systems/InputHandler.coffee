class exports.InputHandler
	constructor: () ->
		document.oncontextmenu = () -> false
		document.addEventListener 'click', (e) -> 
			Event.call new MouseDownEvent e.buttons, new Vector2 e.clientX, e.clientY