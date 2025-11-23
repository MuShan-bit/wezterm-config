local config_util = require("utils.config")
local launch_config = require("config.launch")
local bindings_config = require("config.bindings")
local general_config = require("config.general")
local plugins = require("plugins")

local config = config_util.init_config()

config_util.merge_config(config, general_config)
config_util.merge_config(config, launch_config)
config_util.merge_config(config, bindings_config)

plugins.load()

return config
