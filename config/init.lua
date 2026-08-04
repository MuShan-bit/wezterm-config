local config_util = require("utils.config")

local modules = {
    "config.general",
    "config.launch",
    "config.bindings",
}

local M = {}

function M.build()
    local config = config_util.init_config()

    for _, module_name in ipairs(modules) do
        config_util.merge_config(config, require(module_name))
    end

    return config
end

return M
