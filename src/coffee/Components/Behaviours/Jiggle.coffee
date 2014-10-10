class Jiggle extends Behaviour
	constructor: () ->
		@jiggleRate = 10

	update: () ->
		(@entity.get Transform).position.x += @jiggleRate
		@jiggleRate *= -1

exports.Jiggle = Jiggle