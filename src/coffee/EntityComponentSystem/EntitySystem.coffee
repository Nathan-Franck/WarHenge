class EntitySystem

	constructor: () ->
		@entities = new Array()

	createEntity: () ->
		newEntity = new Entity()
		@entities.push(newEntity)
		return newEntity
	foreach: (ComponentClass, action) ->
		for entity in @entities
			components = entity.getAll ComponentClass
			if components?
				for component in components
					action(component)

global.EntitySystem = EntitySystem
window.EntitySystem = EntitySystem