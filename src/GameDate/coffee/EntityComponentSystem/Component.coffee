class exports.Component
	constructor: () ->
		@entity = null
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
