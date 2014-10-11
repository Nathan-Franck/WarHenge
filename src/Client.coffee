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

		new JigglyCheckmark()
			.getOrCreate(Transform)
			.setPosition(
				new Vector2(
					400
					600
				)
			)

		for i in [0..2000]
			new InvisibleJigglyCheckmark()
				.getOrCreate(Transform)
				.setPosition(
					new Vector2(
						Math.random() * 800
						Math.random() * 600
					)
				)

exports.Client = Client