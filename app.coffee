global.window = {}

require './FileHelper'
require './RequireHelper'
require './Server'

new Server(8000, __dirname)