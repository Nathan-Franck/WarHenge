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

		mainLoop = () ->
			for system in systems
				system.update()
			requestAnimationFrame(mainLoop)

		for i in [0..10]
			new JigglyCheckmark()
				.getOrCreate(Transform)
				.setPosition(
					new Vector2(
						Math.random() * 800
						Math.random() * 600
					)
				)

		o = (Entity.getAll Transform)[0]
		str = Serializer.toJSONString Transform, o
		console.log Serializer.fromJSONString Transform, str, o

		mainLoop()