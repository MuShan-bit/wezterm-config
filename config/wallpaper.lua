local wezterm = require("wezterm")

local M = {}

local WALLPAPER_DIR = wezterm.config_dir .. "/background/random"
local OVERLAY_OPACITY = 0.7
local TRANSPARENT_COLOR = "black"
local SUPPORTED_EXTENSIONS = {
    jpg = true,
    jpeg = true,
    png = true,
    webp = true,
}

local wallpaper_cache = {}

M.modes = {
    transparent = "transparent",
    solid = "solid",
    fixed = "fixed",
    random = "random",
}

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

local function scan_with_glob(directory)
    if not wezterm.glob then
        return nil
    end

    local wallpapers = {}
    for _, path in ipairs(wezterm.glob(directory .. "/*")) do
        if is_supported_image(path) and file_exists(path) then
            table.insert(wallpapers, path)
        end
    end

    return wallpapers
end

local function scan_with_find(directory)
    local wallpapers = {}
    local command = string.format(
        "find %q -type f 2>/dev/null",
        directory
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

function M.get_wallpaper_files(directory)
    directory = directory or WALLPAPER_DIR
    if wallpaper_cache[directory] then
        return wallpaper_cache[directory]
    end

    local wallpapers = scan_with_glob(directory) or scan_with_find(directory)
    table.sort(wallpapers)
    wallpaper_cache[directory] = wallpapers
    return wallpapers
end

function M.clear_cache(directory)
    if directory then
        wallpaper_cache[directory] = nil
    else
        wallpaper_cache = {}
    end
end

function M.get_random_wallpaper(directory)
    local wallpapers = M.get_wallpaper_files(directory)
    if #wallpapers == 0 then
        return nil
    end

    return wallpapers[math.random(#wallpapers)]
end

local function transparent_layer()
    return {
        source = { Color = TRANSPARENT_COLOR },
        width = "100%",
        height = "100%",
        opacity = OVERLAY_OPACITY,
    }
end

local function solid_layer(color)
    return {
        source = { Color = color },
        width = "100%",
        height = "100%",
        opacity = 1,
    }
end

local function image_layer(path)
    return {
        source = { File = path },
        width = "100%",
        height = "100%",
    }
end

local function transparent_background()
    return { transparent_layer() }
end

local function image_background(path)
    if not path or not file_exists(path) then
        wezterm.log_warn("未找到背景图像；已回退到透明背景")
        return transparent_background()
    end

    return { image_layer(path) }
end

function M.get_background_config(options)
    options = options or {}
    local mode = options.mode or M.modes.transparent

    if mode == M.modes.transparent then
        return transparent_background()
    end

    if mode == M.modes.solid then
        return { solid_layer(options.color or TRANSPARENT_COLOR) }
    end

    if mode == M.modes.fixed then
        return image_background(options.path)
    end

    if mode == M.modes.random then
        local path = M.get_random_wallpaper(options.path or WALLPAPER_DIR)
        return image_background(path)
    end

    wezterm.log_warn("未知背景模式；已回退到透明背景：" .. tostring(mode))
    return transparent_background()
end

math.randomseed(os.time())

return M
