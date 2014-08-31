class RequireHelper

	coffeescript = require 'coffee-script'
	fs = require 'fs'
	uglify = require 'uglify-js'

	@translateFile: (filename, data) =>
		if filename.endsWith ".coffee"
			return coffeescript.compile data
		return data
	@findAndExecuteOnSource: (directory, action) ->
		FileHelper.findAndExecute directory + "/src", /.coffee$|.js$/, action
	@requireAllSourceFiles: (directory, doOverTolerance) ->
		console.log "Getting required source files..."
		tooManyDoOvers = () -> doOvers > doOverTolerance
		done = []
		doOvers = 0
		doAgain = true
		error = false
		while doAgain and not error
			doAgain = false
			RequireHelper.findAndExecuteOnSource directory, (file) =>
				if (done.indexOf file) < 0
					try
						require "." + file.slice(directory.length).split(".")[0]
						console.log "	" + file
						done.push file
					catch err
						if (/is not defined/.exec err.message)? and !tooManyDoOvers()
							doAgain = true
						else
							console.log err.stack
							error = true
			doOvers += 1
		return done
	@compileMegaSourceFile: (directory) ->
		megaSource = ""
		requiredFiles = @requireAllSourceFiles directory, 10
		console.log "Compiling mega-source file..."
		requiredFiles.forEach (fileName) ->
			data = fs.readFileSync fileName, "utf-8"
			megaSource += RequireHelper.translateFile fileName, data
			megaSource += "\n"
		#megaSource = uglify.minify(megaSource, {fromString: true})
		return megaSource

global.RequireHelper = RequireHelper
window.RequireHelper = RequireHelper