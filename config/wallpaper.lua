local wezterm = require("wezterm")

-- 随机壁纸配置模块
local M = {}

-- 验证文件是否存在
function M.file_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

-- 通过系统命令获取目录中的图片文件
function M.get_wallpaper_files()
    local wallpaper_dir = wezterm.config_dir .. "/background/random/"
    local wallpapers = {}

    -- 使用find命令查找图片文件
    local handle = io.popen('find "' ..
    wallpaper_dir .. '" -type f \\( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \\) 2>/dev/null')
    if handle then
        for file in handle:lines() do
            if M.file_exists(file) then
                table.insert(wallpapers, file)
            end
        end
        handle:close()
    end

    -- 如果find命令失败，尝试使用ls命令
    if #wallpapers == 0 then
        local handle2 = io.popen('ls "' .. wallpaper_dir .. '" 2>/dev/null')
        if handle2 then
            for file in handle2:lines() do
                local full_path = wallpaper_dir .. file
                if (file:match("%.jpg$") or file:match("%.png$") or file:match("%.jpeg$")) and M.file_exists(full_path) then
                    table.insert(wallpapers, full_path)
                end
            end
            handle2:close()
        end
    end

    return wallpapers
end

-- 获取随机壁纸
function M.get_random_wallpaper()
    local wallpapers = M.get_wallpaper_files()

    -- 如果没有找到壁纸文件，返回nil
    if #wallpapers == 0 then
        return nil
    end

    -- 使用标准Lua函数生成随机种子
    math.randomseed(os.time())

    -- 随机选择一张壁纸
    return wallpapers[math.random(#wallpapers)]
end

-- 获取壁纸背景配置
function M.get_background_config()
    local wallpaper_path = M.get_random_wallpaper()

    -- 如果没有找到壁纸，使用默认的黑色背景
    if not wallpaper_path then
        return {
            {
                source = {
                    Color = "black",
                },
                width = "100%",
                height = "100%",
                opacity = 0.7,
            },
        }
    end

    return {
        {
            source = {
                File = wallpaper_path,
            },
            width = "100%",
            height = "100%",
        },
        {
            source = {
                Color = "black",
            },
            width = "100%",
            height = "100%",
            opacity = 0.7,
        },
    }
end

return M
