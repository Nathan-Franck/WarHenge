class BehaviourSystem extends System
	update: () =>
		@entitySystem.foreach Behaviour, (behaviour) =>
			behaviour.update()

global.BehaviourSystem = BehaviourSystem
window.BehaviourSystem = BehaviourSystem