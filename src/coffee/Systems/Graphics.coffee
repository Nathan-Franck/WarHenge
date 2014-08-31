class Graphics extends System

	constructor: (width, height) ->
		@images = {}
		@stage = new PIXI.Stage 0x33FF55, true
		@renderer = PIXI.autoDetectRenderer width, height
		@renderer.view.style.position = "absolute"
		@renderer.view.style.top = "0px"
		@renderer.view.style.left = "0px"
		document.body.appendChild @renderer.view

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
		@entitySystem.foreach Renderer, (renderer) =>
			sprite = renderer.getSprite()
			if sprite == null
				image = @getImage renderer.image
				sprite = new PIXI.Sprite(image)
				@stage.addChild sprite
				renderer.setSprite(sprite)
			sprite.position = (renderer.entity.getOrCreate Transform).position
		@renderer.render(@stage);

window.Graphics = Graphics
global.Graphics = Graphics