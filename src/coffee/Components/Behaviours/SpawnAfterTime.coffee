class exports.SpawnAfterTime extends Behaviour
	constructor: () ->
		@startTime = Time.time
	setObj: (@obj) -> @
	setTime: (@time) -> @
	update: () ->
		if (Time.time - @startTime > @time)
			(new @obj).getOrCreate(Transform).setPosition(
				@entity.getOrCreate(Transform).getPosition().copy()
				.add(Vector2.randomInsideCircle().scale(40)))
			@kill()
