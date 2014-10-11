class exports.InvisibleJigglyCheckmark extends Entity
	initialize: () ->
		(@add Transform).setPosition(new Vector2(0, 0))
		(@add Jiggle)