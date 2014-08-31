class Entity

	constructor: () ->
		@componentBin = {}

	indexOf: (Prototype) ->
		return Prototype.constructor.name
	add: (ComponentClass) ->
		newComponent = new ComponentClass();
		newComponent.setEntity @
		@addExisting newComponent, ComponentClass.prototype
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

window.Entity = Entity
global.Entity = Entity