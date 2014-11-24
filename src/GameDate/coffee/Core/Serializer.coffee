class exports.Serializer
	@toJSON: (type, o) ->
		if !(type?)
			return o
		json = {}
		if type.fields?
			for field in type.fields
				if !(field.var)
					continue
				json[field.var] = Serializer.toJSON field.type, o[field.var]
		return json
	@fromJSON: (type, json, o) ->
		if !(type?)
			return o
		if !(o?)
			o = new type()
		if type.fields?
			for field in type.fields
				if !(field.var)
					continue
				o[field.var] = Serializer.fromJSON field.type, json[field.var], o[field.var]
		return o
	@fromJSONString: (type, json, o) ->
		return Serializer.fromJSON type, (JSON.parse json), o
	@toJSONString: (type, o) ->
		return JSON.stringify Serializer.toJSON type, o

class SerializerTester
	genericTest: () ->
		o = (Entity.getAll Transform)[0]
		if (o?)
			console.log o
			str = Serializer.toJSONString Transform, o
			console.log Serializer.fromJSONString Transform, str, o