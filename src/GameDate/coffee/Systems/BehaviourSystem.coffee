class exports.BehaviourSystem extends System
	update: () =>
		for behaviour in Entity.getAll Behaviour
			behaviour.update()