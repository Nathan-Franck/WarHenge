class Renderer extends Component
	@renderers: []
	constructor: () ->
		@image = null
		@sprite = null
		Renderer.renderers.push @
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