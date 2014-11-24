class exports.SpawnAfterTime extends Behaviour
	constructor: () ->
		@startTime = Time.time
	update: () ->
		if (Time.time - @startTime > @time)
			(new @obj).getOrCreate(Transform).position = 
				@entity.getOrCreate(Transform).position.copy()
				.add(Vector2.randomInsideCircle().scale(40))
			@kill()
