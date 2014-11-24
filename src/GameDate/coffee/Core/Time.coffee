class exports.Time extends System
	@time: 0
	@deltaTime: 0
	constructor: ->
		@update()
	update: ->
		lastTime = Time.time
		Time.time = new Date().getTime() / 1000
		Time.deltaTime = Time.time - lastTime