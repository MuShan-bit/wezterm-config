local config_util = require("utils.config")
local launch_config = require("config.launch")
local bindings_config = require("config.bindings")
local general_config = require("config.general")

local config = config_util.initConfig()

config_util.mergeConfig(config, general_config)
config_util.mergeConfig(config, launch_config)
config_util.mergeConfig(config, bindings_config)

return config
