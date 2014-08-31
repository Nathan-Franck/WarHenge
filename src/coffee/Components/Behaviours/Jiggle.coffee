class Jiggle extends Behaviour
	constructor: () ->
		@jiggleRate = 10

	update: () ->
		(@entity.get Transform).position.x += @jiggleRate
		@jiggleRate *= -1

global.Jiggle = Jiggle
window.Jiggle = Jiggle