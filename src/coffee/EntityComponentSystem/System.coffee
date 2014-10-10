class System
	setUpdateRate: (@updateRate) -> @
	start: () ->
		setInterval(@update, @updateRate * 1000)
	update: () ->
		@

exports.System = System