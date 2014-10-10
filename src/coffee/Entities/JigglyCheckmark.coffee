class exports.JigglyCheckmark extends Entity
	constructor: () ->
		super()
		(@add Renderer).setImage("img/Success.png")
		(@add Transform).setPosition(new Vector2(20, 40))
		@add Jiggle
		@add MuchFun