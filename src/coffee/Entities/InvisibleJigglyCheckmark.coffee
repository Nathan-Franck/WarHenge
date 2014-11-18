class exports.InvisibleJigglyCheckmark extends Entity
	constructor: () ->
		(@add Transform).position = new Vector2(0, 0)
		(@add Jiggle)