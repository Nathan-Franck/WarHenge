class System
	setEntitySystem: (@entitySystem) -> 
		@
	setUpdateRate: (@updateRate) -> @
	start: () ->
		setInterval(@update, @updateRate * 0.001)
	update: () ->
		@

window.System = System
global.System = System