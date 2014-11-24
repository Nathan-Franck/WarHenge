class exports.FileHelper

	fs = require 'fs'

	@findWithin: (dir, regExp) ->
		results = []
		FileHelper.findAndExecute(dir, regExp, (file) -> results.push file)
		return results

	@findAndExecute: (dir, regExp, action) ->
		list = fs.readdirSync dir
		list.forEach (file) ->
			file = dir + '/' + file
			stat = fs.statSync file
			if stat and stat.isDirectory()
				FileHelper.findAndExecute file, regExp, action
			else
				filter = regExp.exec file
				if filter? then action file