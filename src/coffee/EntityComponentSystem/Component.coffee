class exports.Component
	setEntity: (@entity) -> @
	getEntity: () -> @entity
	serialize: () -> {}
	deserialize: (obj) -> @
	kill: () ->
		DestroySystem.queue @
	destroy: () ->
		@entity.remove @
	type: () ->
		return @constructor.name
	toString: () ->
		return "#{@type()} Component"
