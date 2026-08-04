local config = require("config").build()
local plugins = require("plugins")

plugins.load(config)

return config
