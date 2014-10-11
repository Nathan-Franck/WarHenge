class Client
	constructor: () ->
		systems = [
			new Time()
			new BehaviourSystem()
			new DestroySystem()
			new Graphics()
		]

		mainLoop = () ->
			for system in systems
				system.update()
			requestAnimationFrame(mainLoop)
		requestAnimationFrame(mainLoop)

		for i in [0..1000]
			new JigglyCheckmark()
				.getOrCreate(Transform)
				.setPosition(
					new Vector2(
						Math.random() * 800
						Math.random() * 600
					)
				)

exports.Client = Client