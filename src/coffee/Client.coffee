class exports.Client
	constructor: () ->
		new InputHandler()

		systems = [
			new Time()
			new UnitCommandSystem()
			new BehaviourSystem()
			new DestroySystem()
			new Graphics()
		]

		playing = true

		document.addEventListener("focus", () -> 
			console.log "Resuming!"
			mainLoop()
		, true)
		mainLoop = () ->
			for system in systems
				system.update()
			if document.hasFocus()
				requestAnimationFrame(mainLoop)
			else
				console.log "Pausing..."

		for i in [0..10000]
			(new JigglyCheckmark())
				.getOrCreate(Transform)
				.position =
					new Vector2(
						Math.random() * 800
						Math.random() * 600
					)

		o = (Entity.getAll Transform)[0]
		if (o?)
			console.log o
			str = Serializer.toJSONString Transform, o
			console.log Serializer.fromJSONString Transform, str, o

		mainLoop()
