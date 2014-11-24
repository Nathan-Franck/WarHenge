class exports.Client
	constructor: () ->

		for i in [0..100]
			(new JigglyCheckmark())
				.getOrCreate(Transform)
				.position =
					new Vector2(
						Math.random() * 800
						Math.random() * 600
					)

		new DocumentLoop(
			new SystemHandler([
				new InputHandler()
				new Time()
				new UnitCommandSystem()
				new BehaviourSystem()
				new DestroySystem()
				new Graphics()
			]).update
		)