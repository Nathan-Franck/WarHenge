class exports.UnitCommandSystem extends System
	constructor: () ->
		@registerEvents()
		@selected = []
		@commandPosition = new Vector2(0, 0)
	registerEvents: () ->
		Event.register(MouseDownEvent, @onClickEvent)
	onClickEvent: (e) ->
		console.log "Such click!" + e.position