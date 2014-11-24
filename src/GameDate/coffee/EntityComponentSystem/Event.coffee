class exports.Event
	@eventRegisterContainer: {}
	@call: (e) ->
		funcs = Event.funcsForEvent e
		if !(funcs?) then return false
		for func in funcs
			func(e)
		return true
	@register: (EventPrototype, func) ->
		funcs = Event.funcsForEvent EventPrototype
		funcs.push func
	@unregister: (EventPrototype, func) ->
		funcs = Event.funcsForEvent EventPrototype
		index = funcs.indexOf func
		if index < 0 then return false
		funcs.splice index, 1
		return true
	@nameForEvent: (EventPrototype) ->
		return EventPrototype.constructor.name
	@funcsForEvent: (EventPrototype) ->
		name = Event.nameForEvent Event
		funcs = Event.eventRegisterContainer[name]
		if !(funcs?) then funcs = Event.eventRegisterContainer[name] = []
		return funcs
