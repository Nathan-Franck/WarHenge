class exports.UnitCommandSystem extends System
	constructor: () ->
		@registerEvents()
		@selected = []
		@commandPosition = new Vector2 0, 0
	registerEvents: () ->
		Event.register MouseDownEvent, @onClickEvent
	onClickEvent: (e) ->
		for commandable in Entity.getAll Commandable
			distance = (commandable.entity.get Transform).position.distance e.position
			if distance < 50
				console.log "Such click!" + e.position