class BehaviourSystem extends System
	update: () =>
		Entity.foreach Behaviour, (behaviour) =>
			behaviour.update()

exports.BehaviourSystem = BehaviourSystem