local tabline_plugin = require("plugins.tabline")
local ssh_plugin = require("plugins.ssh")

local M = {}

local enabled_plugins = {
    tabline = true,
    ssh = true,
}

function M.load(config)
    if enabled_plugins.tabline then
        tabline_plugin.setup()
    end

    if enabled_plugins.ssh then
        ssh_plugin.setup(config)
    end
end

return M
