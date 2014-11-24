class Jiggle extends Behaviour

	constructor: () ->
		@jiggleRate = 100	
		@angle = Math.random() * 100

	update: () ->
		position = @entity.getTransform().position
		offset = new Vector2(Math.cos(@angle), Math.sin(@angle))
		offset.scale(Time.deltaTime * @jiggleRate)
		@angle += Time.deltaTime * Math.PI * 5
		position.add(offset)

exports.Jiggle = Jiggle