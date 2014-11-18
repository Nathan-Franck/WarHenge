class exports.Renderer extends Component
	@fields = [
		{var: "image"}
	]
	constructor: () ->
		@image = null
		@sprite = null
		@tint = 0xFFFFFF
	destroy: () ->
		super
		if @sprite? and @sprite.parent?
			@sprite.parent.removeChild @sprite