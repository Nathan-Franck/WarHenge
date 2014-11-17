class exports.JigglyCheckmark extends Entity
	initialize: () ->
		(@add Renderer)
			.setImage("img/Success.png")
			.setTint(0xFFFFFF * Math.random())
		(@add Transform).setPosition(new Vector2(0, 0))
		@add Jiggle
		@add Commandable