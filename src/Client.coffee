class Client
	constructor: () ->
		entitySystem = new EntitySystem();

		ent = entitySystem.createEntity();
		(ent.add Renderer).setImage("img/Success.png")
		(ent.add Transform).setPosition(new Vector2(20, 40))
		ent.add Jiggle

		ent = entitySystem.createEntity();
		(ent.add Renderer).setImage("img/Success.png")
		(ent.add Transform).setPosition(new Vector2(40, 40))
		ent.add Jiggle

		new Graphics(800, 600)
			.setEntitySystem(entitySystem)
			.setUpdateRate(0.033)
			.start()

		new BehaviourSystem()
			.setEntitySystem(entitySystem)
			.setUpdateRate(0.0333)
			.start()

global.Client = Client
window.Client = Client