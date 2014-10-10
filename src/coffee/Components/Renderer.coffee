class Renderer extends Component
	constructor: () ->
		@image = null
		@sprite = null
	setImage: (@image) -> @
	getImage: () -> @image
	setSprite: (@sprite) -> @
	getSprite: () -> @sprite

exports.Renderer = Renderer