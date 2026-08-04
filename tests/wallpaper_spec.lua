package.path = "./?.lua;./?/init.lua;" .. package.path

local temporary_path = os.tmpname()
os.remove(temporary_path)
local fixture_path = temporary_path .. ".png"
local fixture_file = assert(io.open(fixture_path, "w"))
fixture_file:write("fixture")
fixture_file:close()

package.preload["wezterm"] = function()
    return {
        config_dir = "/tmp/wezterm-config",
        glob = function(directory)
            if directory == "/tmp/wallpapers/*" then
                return { fixture_path }
            end
            return {}
        end,
        log_warn = function() end,
    }
end

local wallpaper = require("config.wallpaper")

local transparent = wallpaper.get_background_config()
assert(transparent[1].source.Color == "black")
assert(transparent[1].opacity == 0.7)

local solid = wallpaper.get_background_config({
    mode = wallpaper.modes.solid,
    color = "#123456",
})
assert(solid[1].source.Color == "#123456")
assert(solid[1].opacity == 1)

local fixed = wallpaper.get_background_config({
    mode = wallpaper.modes.fixed,
    path = fixture_path,
})
assert(fixed[1].source.File == fixture_path)

local random = wallpaper.get_background_config({
    mode = wallpaper.modes.random,
    path = "/tmp/wallpapers",
})
assert(random[1].source.File == fixture_path)

os.remove(fixture_path)
