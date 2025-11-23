local tabline_plugin = require("plugins.tabline")

local M = {}
function M.load()
    -- tab栏插件
    tabline_plugin.setup()
end

return M