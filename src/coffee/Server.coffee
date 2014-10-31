class exports.Server

	coffeescript = require 'coffee-script'
	jade = require 'jade'
	http = require 'http'
	fs = require 'fs'
	util = require 'util'
	RequireHelper = (require './Helpers/RequireHelper').RequireHelper
	rl = require 'readline'

	constructor: (@port, @directory) ->
		@commands = ["quit", "help", "updateSource", "clear"]
		RequireHelper.watchDirectory(@directory, @markSourceAsDirty)
		@updateSource()
		@cache = {}
		@server = http.createServer @handleRequest
		@server.listen @port
		console.log "Server started on port " + @port + "!"
		@startInput()
	processFilename: (filename) =>
		if filename == '/'
			filename = '/index.jade';
		return @directory + filename;
	processDataDynamic: (filename, data) =>
		if filename.endsWith ".coffee"
			return coffeescript.compile data
		if filename.endsWith ".jade"
			return (jade.compile data)()
		return data
	markSourceAsDirty: () =>
		if @isSourceDirty then return
		@isSourceDirty = true
		console.log "Source code has changed, will compile at next request"
	cacheFile: (filename, data) =>
		@cache[filename] = data
	retrieveCachedFile: (filename) =>
		@cache[filename]
	sendCachedFile: (filename, res) =>
		data = @retrieveCachedFile filename
		if data != undefined
			res.writeHead 200;
			res.end data
	sendDynamicFile: (filename, res) =>
		handleFile = (err, data) =>
			if err
				res.writeHead 500;
				res.end "File Not Found"
			else
				data = @processDataDynamic filename, data
				@cacheFile filename, data
				res.writeHead 200
				res.end data
		if filename.endsWith ".coffee" or filename.endsWith ".jade"
			fs.readFile filename, "utf-8", handleFile
		else
			fs.readFile filename, handleFile
	handleRequest: (req, res) =>
		if req.url == "/megaSource.js"
			if @isSourceDirty
				@updateSource()
				@isSourceDirty = false
			res.writeHead 200
			res.end @megaSource
		filename = @processFilename req.url
		if !@sendCachedFile filename, res
			@sendDynamicFile filename, res
	startInput: () =>
		rl = rl.createInterface({
			input: process.stdin,
			output: process.stdout
		})
		rl.setPrompt "> ", 2
		rl.on 'line', @handleConsoleCommand
		rl.prompt({preserveCursor: true})
		# console.log = () => @consoleOut("log", arguments);
		# console.warn = () => @consoleOut("warn", arguments);
		# console.info = () => @consoleOut("info", arguments);
		# console.error = () => @consoleOut("error", arguments);
	handleConsoleCommand: (cmd) =>
		legal = @commands.indexOf(cmd) >= 0
		command = this[cmd]
		if legal and command? 
			command()
		rl.prompt()
	consoleOut: (type, args) ->
	    t = Math.ceil((rl.line.length + 3) / process.stdout.columns)
	    text = util.format.apply(console, args)
	    rl.output.write("\n\x1B[" + t + "A\x1B[0J")
	    rl.output.write(text + "\n")
	    rl.output.write(Array(t).join("\n\x1B[E"))
	    rl._refreshLine()
	updateSource: () =>
		@megaSource = RequireHelper.compileMegaSourceFile @directory
	quit: () =>
		process.exit()
	help: () =>
		console.log "Available commands:"
		for command in @commands
			console.log "	" + command
	clear: () =>
		process.stdout.write '\u001B[2J\u001B[0;0f'