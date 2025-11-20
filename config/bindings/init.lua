local platform = require("utils.platform")
local mac_bingdings = require("config.bindings.mac_bindings")
local win_bindings = require("config.bindings.win_bindings")


if platform.is_win then
    return win_bindings
elseif platform.is_mac then
    return mac_bingdings
end

return {
    disable_default_key_bindings = false,
    disable_default_mouse_bindings = false,
    leader = { key = "Space", mods = "CTRL|SHIFT" },
}
