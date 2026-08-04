local wezterm = require("wezterm")

local M = {}

M.styles = {
    random = "random",
    fixed = "fixed",
    solid = "solid",
    transparent = "transparent",
}

local DEFAULTS = {
    random_dir = wezterm.config_dir .. "/background/random",
    fixed_path = wezterm.config_dir .. "/background/night.png",
    color = "#0d1117",
    overlay_opacity = 0.68,
    brightness = 0.85,
}

local supported_extensions = {
    jpg = true,
    jpeg = true,
    png = true,
    webp = true,
}

local wallpaper_cache = {}

math.randomseed(os.time())

local function shell_quote(value)
    return "'" .. value:gsub("'", "'\\''") .. "'"
end

local function file_exists(path)
    local file = io.open(path, "r")
    if not file then
        return false
    end

    file:close()
    return true
end

local function image_background(path, options)
    return {
        {
            source = { File = path },
            width = "Cover",
            height = "Cover",
            horizontal_align = "Center",
            vertical_align = "Middle",
            repeat_x = "NoRepeat",
            repeat_y = "NoRepeat",
            attachment = "Fixed",
            hsb = { brightness = options.brightness },
        },
        {
            source = { Color = "black" },
            width = "100%",
            height = "100%",
            opacity = options.overlay_opacity,
        },
    }
end

local function color_background(color, opacity)
    return {
        {
            source = { Color = color },
            width = "100%",
            height = "100%",
            opacity = opacity or 1,
        },
    }
end

local function get_wallpaper_files(directory)
    if wallpaper_cache[directory] then
        return wallpaper_cache[directory]
    end

    local wallpapers = {}
    local handle = io.popen(string.format("find %s -type f 2>/dev/null", shell_quote(directory)))

    if not handle then
        wezterm.log_warn("无法扫描壁纸目录：" .. directory)
        wallpaper_cache[directory] = wallpapers
        return wallpapers
    end

    for path in handle:lines() do
        local extension = path:match("%.([^./]+)$")
        if extension and supported_extensions[extension:lower()] then
            table.insert(wallpapers, path)
        end
    end
    handle:close()

    table.sort(wallpapers)
    wallpaper_cache[directory] = wallpapers
    return wallpapers
end

local function random_wallpaper(directory)
    local wallpapers = get_wallpaper_files(directory)
    if #wallpapers == 0 then
        return nil
    end

    return wallpapers[math.random(#wallpapers)]
end

local function with_defaults(options)
    options = options or {}
    return {
        style = options.style or M.styles.random,
        random_dir = options.random_dir or DEFAULTS.random_dir,
        fixed_path = options.fixed_path or DEFAULTS.fixed_path,
        color = options.color or DEFAULTS.color,
        overlay_opacity = options.overlay_opacity or DEFAULTS.overlay_opacity,
        brightness = options.brightness or DEFAULTS.brightness,
    }
end

function M.get_background_config(options)
    local config = with_defaults(options)

    if config.style == M.styles.transparent then
        return color_background(config.color, 0)
    end

    if config.style == M.styles.solid then
        return color_background(config.color)
    end

    local wallpaper_path
    if config.style == M.styles.fixed then
        wallpaper_path = config.fixed_path
    elseif config.style == M.styles.random then
        wallpaper_path = random_wallpaper(config.random_dir)
    else
        wezterm.log_warn("未知背景风格：" .. tostring(config.style) .. "；已使用纯色背景")
        return color_background(config.color)
    end

    if not wallpaper_path or not file_exists(wallpaper_path) then
        wezterm.log_warn("未找到壁纸；已使用纯色背景")
        return color_background(config.color)
    end

    return image_background(wallpaper_path, config)
end

function M.get_window_background_opacity(options)
    local config = with_defaults(options)
    if config.style == M.styles.transparent then
        return 0
    end

    return 1
end

function M.clear_cache()
    wallpaper_cache = {}
end

return M
