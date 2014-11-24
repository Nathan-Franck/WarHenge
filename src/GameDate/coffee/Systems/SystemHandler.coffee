class exports.SystemHandler extends System
	constructor: (@systems) ->
	update: () =>
		for system in @systems
			system.update()