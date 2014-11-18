class exports.JigglyCheckmark extends Entity
	constructor: () ->
		renderer = @add Renderer
		renderer.image = "img/Success.png"
		renderer.tint = 0xFFFFFF * Math.random()
		(@add Transform).position = new Vector2(0, 0)
		@add Jiggle
		@add Commandable