class Server

	coffeescript = require 'coffee-script'
	jade = require 'jade'
	http = require 'http'
	fs = require 'fs'

	constructor: (port, directory) ->
		@megaSource = RequireHelper.compileMegaSourceFile directory
		console.log "ATTN: Server caches files, changes to files will not be acknowledged until restart"
		@directory = directory
		@cache = {}
		server = http.createServer @handleRequest
		server.listen port
		console.log "Server started on port " + port + "!"
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
		if req.url == "/megaSource"
			res.writeHead 200
			res.end @megaSource
		filename = @processFilename req.url
		if !@sendCachedFile filename, res
			@sendDynamicFile filename, res

global.Server = Server
window.Server = Server