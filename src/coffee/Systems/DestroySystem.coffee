class exports.DestroySystem extends System
	@destroyQueue: []
	@queue: (obj) -> 
		DestroySystem.destroyQueue.push(obj)
	update: () ->
		for obj in DestroySystem.destroyQueue
			obj.destroy()
		DestroySystem.destroyQueue = []
