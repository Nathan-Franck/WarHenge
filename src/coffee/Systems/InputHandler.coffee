class exports.InputHandler
	constructor: () ->
		document.oncontextmenu = () -> false
		document.addEventListener 'mousedown', (e) -> 
			Event.call new MouseDownEvent e.buttons, new Vector2 e.clientX, e.clientY
