local wezterm = require("wezterm")

local M = {}

local WALLPAPER_DIR = wezterm.config_dir .. "/background/random"
local OVERLAY_OPACITY = 0.7
local SUPPORTED_EXTENSIONS = {
    jpg = true,
    jpeg = true,
    png = true,
    webp = true,
}

local wallpaper_cache

local function file_exists(path)
    local file = io.open(path, "r")
    if not file then
        return false
    end

    file:close()
    return true
end

-- 保留公开方法，方便其他配置模块复用。
M.file_exists = file_exists

local function is_supported_image(path)
    local extension = path:match("%.([^./]+)$")
    return extension ~= nil and SUPPORTED_EXTENSIONS[extension:lower()] == true
end

local function scan_with_glob()
    if not wezterm.glob then
        return nil
    end

    local wallpapers = {}
    for _, path in ipairs(wezterm.glob(WALLPAPER_DIR .. "/*")) do
        if is_supported_image(path) and file_exists(path) then
            table.insert(wallpapers, path)
        end
    end

    return wallpapers
end

local function scan_with_find()
    local wallpapers = {}
    local command = string.format(
        "find %q -type f 2>/dev/null",
        WALLPAPER_DIR
    )
    local handle = io.popen(command)

    if not handle then
        return wallpapers
    end

    for path in handle:lines() do
        if is_supported_image(path) and file_exists(path) then
            table.insert(wallpapers, path)
        end
    end
    handle:close()

    return wallpapers
end

function M.get_wallpaper_files()
    if wallpaper_cache then
        return wallpaper_cache
    end

    wallpaper_cache = scan_with_glob() or scan_with_find()
    table.sort(wallpaper_cache)
    return wallpaper_cache
end

function M.clear_cache()
    wallpaper_cache = nil
end

function M.get_random_wallpaper()
    local wallpapers = M.get_wallpaper_files()
    if #wallpapers == 0 then
        return nil
    end

    return wallpapers[math.random(#wallpapers)]
end

local function color_layer()
    return {
        source = { Color = "black" },
        width = "100%",
        height = "100%",
        opacity = OVERLAY_OPACITY,
    }
end

function M.get_background_config()
    return { color_layer() }
end

math.randomseed(os.time())

return M
