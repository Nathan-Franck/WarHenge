class Vector2
	constructor: (@x, @y) ->
	add: (v) -> 
		@x += v.x
		@y += v.y
		@
	sub: (v) ->
		@x -= v.x
		@y -= v.y
		@
	scale: (x) ->
		@x *= x
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