class Component
	setEntity: (@entity) -> @
	getEntity: () -> @entity
	serialize: () -> {}
	deserialize: (obj) -> @

exports.Component = Component