class exports.Graphics extends System

	constructor: () ->
		@images = {}
		@stage = new PIXI.Stage 0x000000, true
		@renderer = PIXI.autoDetectRenderer()
		@renderer.view.style.position = "absolute"
		@renderer.view.style.top = "0px"
		@renderer.view.style.left = "0px"
		document.body.appendChild @renderer.view
		window.addEventListener 'resize', @onResize, false
		@onResize()

	onResize: () =>
		width = window.innerWidth
		height = window.innerHeight
		@renderer.resize width, height

	getImage: (address) =>
		image = @images[address]
		if image != undefined
			return image
		return @loadImage address

	loadImage: (address) =>
		image = PIXI.Texture.fromImage address
		@images[address] = image
		return image

	update: () =>
		renderers = Entity.getAll Renderer
		for renderer in renderers
			if renderer.sprite == null
				image = @getImage renderer.image
				renderer.sprite = new PIXI.Sprite(image)
				renderer.sprite.tint = renderer.tint
				@stage.addChild renderer.sprite
			renderer.sprite.position = (renderer.entity.getTransform()).position
		@renderer.render(@stage);