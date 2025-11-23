local wezterm = require("wezterm")

local function merge_config(target, source)
    for key, value in pairs(source) do
        target[key] = value
    end
end

local function init_config()
    return wezterm.config_builder()
end

return {
    init_config = init_config,
    merge_config = merge_config,
}
