local wezterm = require("wezterm")

local function mergeConfig(target, source)
    for key, value in pairs(source) do
        target[key] = value
    end
end

local function initConfig()
    return wezterm.config_builder()
end

return {
    initConfig = initConfig,
    mergeConfig = mergeConfig,
}
