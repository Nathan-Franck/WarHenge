class Transform extends Component
	constructor: () ->
		@position = new Vector2(0, 0)
		@rotation = 0
	setPosition: (@position) -> @
	getPosition: () -> @position
	setRotation: (@rotation) -> @
	getRotation: () -> @rotation

exports.Transform = Transform