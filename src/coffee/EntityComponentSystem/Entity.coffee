class Entity

	@entities = new Array()
	@foreach: (ComponentClass, action) ->
		for entity in Entity.entities
			components = entity.getAll ComponentClass
			if components?
				for component in components
					action(component)

	@getAll: (ComponentClass) ->
		Entity.globalEntity.getAll(ComponentClass)

	constructor: (@global = false) ->
		@componentBin = {}
		unless @global
			Entity.entities.push @
		@initialize()

	initialize: () ->

	indexOf: (Prototype) ->
		return Prototype.constructor.name
	add: (ComponentClass) ->
		newComponent = new ComponentClass();
		@addExisting newComponent, ComponentClass.prototype
		unless @global
			Entity.globalEntity.addExisting newComponent, ComponentClass.prototype
			newComponent.setEntity @
	addExisting: (newComponent, Prototype) ->
		components = @getAll(Prototype.constructor)
		if !(components?)
			components = new Array()
			@componentBin[@indexOf Prototype] = components
		components.push newComponent
		parentPrototype = Prototype.constructor.__super__
		if parentPrototype? and (@indexOf parentPrototype)? 
			@addExisting newComponent, parentPrototype
		return newComponent
	get: (ComponentClass) ->
		components = @getAll(ComponentClass)
		if !(components?) then return null
		return components[0]
	getOrCreate: (ComponentClass) ->
		component = @get ComponentClass
		if component? then return component
		return @add ComponentClass
	getAll: (ComponentClass) ->
		components = @componentBin[@indexOf ComponentClass.prototype]
		if !(components?) then return null
		return components
	remove: (component) ->
		unless @global
			Entity.globalEntity.remove component
		ComponentClass = component.constructor
		for key, components of @componentBin
			if components?
				for i in [components.length - 1 .. 0] by -1
					if components[i] == component
						components.splice i, 1

	getTransform: ->
		unless @transform?
			@transform = @getOrCreate Transform
		@transform

	@globalEntity = new Entity(true)

exports.Entity = Entity