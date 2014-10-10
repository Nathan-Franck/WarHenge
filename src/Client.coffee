class Client
	constructor: () ->
		new JigglyCheckmark()

		ent = new Entity()
		(ent.add Renderer).setImage("img/Success.png")
		(ent.add Transform).setPosition(new Vector2(40, 40))
		ent.add Jiggle

		new Graphics()
			.setUpdateRate(1/60)
			.start()

		new BehaviourSystem()
			.setUpdateRate(1/2)
			.start()

exports.Client = Client