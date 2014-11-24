class exports.RequireHelper

	coffeescript = require 'coffee-script'
	fs = require 'fs'
	uglify = require 'uglify-js'
	chokidar = require 'chokidar'
	FileHelper = (require './FileHelper').FileHelper

	@classNames = []
	@serverIgnore = ["pixi"]
	@clientIgnore = ["Server", "RequireHelper", "FileHelper"]

	@translateFile: (filename, data) =>
		if filename.endsWith ".coffee"
			return coffeescript.compile data
		return data
	@findAndExecuteOnSource: (directory, action) ->
		FileHelper.findAndExecute directory + "/src", /.coffee$|.js$/, action
	@watchDirectory: (directory, action) ->
		(chokidar.watch directory, {ignoreInitial: true, persistent: true})
		  .on('add', (path) -> action())
		  .on('change', (path) -> action())
		  .on('unlink', (path) -> action())
	@requireAllSourceFiles: (directory, doOverTolerance, verbose = true) -> 
		console.log "Getting required source files..."
		tooManyDoOvers = () -> doOvers > doOverTolerance
		doOvers = 0
		doAgain = true
		error = false
		loaded = []
		global.window = {}
		for className in @classNames
			delete global[className]
		while doAgain and not error
			doAgain = false
			RequireHelper.findAndExecuteOnSource directory, (file) =>
				if (loaded.indexOf file) < 0
					try	
						reqSource = RequireHelper.loadFile(directory, file)
						if verbose 
							console.log "	" + reqSource
						loaded.push file
					catch err
						if (/is not defined/.exec err.message)? and !tooManyDoOvers()
							doAgain = true
						else
							if verbose 
								console.log err.stack
							error = true
			doOvers += 1
		return loaded
	@loadFile: (directory, file) ->
		reqSource = file.slice(directory.length).split(".")[0]
		className = ((list) -> list[list.length - 1])(reqSource.split("/"))
		if RequireHelper.serverIgnore.indexOf(className) >= 0
			return reqSource
		@classNames.push className
		delete require.cache[file]
		req = require file
		global[className] = req[className]
		reqSource
	@compileMegaSourceFile: (directory) ->
		megaSource = ""
		requiredFiles = @requireAllSourceFiles directory, 10
		console.log "Compiling mega-source file..."
		requiredFiles.forEach (fileName) ->
			className = ((list) -> list[list.length - 1])(fileName.split(".")[0].split("/"))
			if RequireHelper.clientIgnore.indexOf(className) >= 0
				return
			data = fs.readFileSync fileName, "utf-8"
			megaSource += RequireHelper.translateFile fileName, data
			megaSource += "\n"
		megaSource = megaSource.replace(/exports/g, "window")
		megaSource = megaSource.replace(/global/g, "window")
		#megaSource = uglify.minify(megaSource, {fromString: true})
		return megaSource