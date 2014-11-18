class exports.Transform extends Component
	@fields = [
		{type: Vector2, var: "position"}
		{var: "rotation"}
	]
	constructor: () ->
		@position = new Vector2(0, 0)
		@rotation = 0