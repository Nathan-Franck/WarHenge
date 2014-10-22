class exports.System
	setUpdateRate: (@updateRate) -> @
	start: () ->
		setInterval(@update, @updateRate * 1000)
	update: () ->
		@