class exports.Entity
	@foreach: (ComponentClass, action) ->
		components = Entity.getAll ComponentClass
		if components?
			for component in components
				action(component)
	@getAll: (ComponentClass) ->
		Entity.GlobalEntity.getAll(ComponentClass)
	constructor: (@isGlobal = false) ->
	indexOf: (Prototype) ->
		return Prototype.constructor.name
	add: (ComponentClass) ->
		newComponent = new ComponentClass();
		@addExisting newComponent, ComponentClass.prototype
		unless @isGlobal
			Entity.GlobalEntity.addExisting newComponent, ComponentClass.prototype
			newComponent.entity = @
		return newComponent
	addExisting: (newComponent, Prototype) ->
		components = @getAll(Prototype.constructor)
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
		if !(@componentBin?) then @componentBin = {}
		components = @componentBin[@indexOf ComponentClass.prototype]
		if !(components?) 
			components = new Array()
			@componentBin[@indexOf ComponentClass.prototype] = components
			return components;
		return components
	remove: (component) ->
		unless @isGlobal
			Entity.GlobalEntity.remove component
		ComponentClass = component.constructor
		if !(@componentBin?) then @componentBin = {}
		for key, components of @componentBin
			if components?
				for i in [components.length - 1 .. 0] by -1
					if components[i] == component
						components.splice i, 1
	getTransform: ->
		unless @transform?
			@transform = @getOrCreate Transform
		return @transform
	@GlobalEntity = new Entity(true)