class Renderer extends Component
	constructor: () ->
		@image = null
		@sprite = null
	setImage: (@image) -> @
	getImage: () -> @image
	setSprite: (@sprite) -> @
	getSprite: () -> @sprite
	setTint: (@tint) -> @
	getTint: () -> @tint
	destroy: () ->
		super
		if @sprite? and @sprite.parent?
			@sprite.parent.removeChild @sprite

exports.Renderer = Renderer