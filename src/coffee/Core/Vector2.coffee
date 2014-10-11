class Vector2
	@randomInsideCircle: ->
		t = Math.random() * Math.PI * 2
		u = Math.random() + Math.random()
		r = if u < 1 then u else 2 - u
		return new Vector2(r * Math.cos(t), r * Math.sin(t))
	constructor: (@x, @y) ->
	add: (v) -> 
		@x += v.x
		@y += v.y
		@
	sub: (v) ->
		@x -= v.x
		@y -= v.y
		@
	mul: (v) ->
		@x *= v.x
		@y *= v.y
		@
	scale: (s) ->
		@x *= s
		@y *= s
		@
	perp: (v) ->
		swap = @y
		@y = -@x
		@x = swap
		@
	dot: (v) ->
		@x*v.x + @y*v.y
	copy: () -> new Vector2 @x, @y
	equals: (v) -> @x == v.x and @y == v.y

exports.Vector2 = Vector2