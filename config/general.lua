local wezterm = require("wezterm")
local wallpaper = require("config.wallpaper")

-- 可选值：random（随机壁纸）、fixed（固定壁纸）、solid（纯色背景）、transparent（透明背景）
local background_options = {
    style = wallpaper.styles.transparent,
    random_dir = wezterm.config_dir .. "/background/random",
    fixed_path = wezterm.config_dir .. "/background/night.png",
    color = "#0d1117",
    overlay_opacity = 0.68,
    brightness = 0.85,
    transparent_opacity = 0.5,
}

return {
    -- 添加字体目录
    font_dirs = { wezterm.config_dir .. "/fonts" },
    -- 设置字体
    font_size = 18,
    cell_width = 1.0,
    font = wezterm.font("Maple Mono NF CN"),
    -- 设置颜色主题
    color_scheme = 'catppuccin-mocha',
    -- 设置tab栏
    enable_tab_bar = true,
    -- 使用精美的标签栏（反而违和）
    use_fancy_tab_bar = false,
    -- 标签栏宽度
    tab_max_width = 25,
    -- 如果只有一个 tab 时隐藏tab栏
    hide_tab_bar_if_only_one_tab = true,
    -- 显示新建标签页按钮
    show_new_tab_button_in_tab_bar = false,
    --  设置窗口样式
    window_decorations = "RESIZE", -- "NONE" | "FULL" | "RESIZE" | "THIN" | "THICK",
    window_background_opacity = wallpaper.get_window_background_opacity(background_options),
    text_background_opacity = 0.9,
    macos_window_background_blur = 70,
    -- 防止放大缩小字体时窗口大小变化
    adjust_window_size_when_changing_font_size = false,
    -- 设置内边距
    window_padding = {
        left   = '0.6cell',
        right  = '0.6cell',
        top    = '0.4cell',
        bottom = '0.4cell',
    },
    -- 初始状态窗口大小（行数）
    initial_rows = 35,
    initial_cols = 200,
    -- 禁用滚动条
    enable_scroll_bar = false,
    -- 增加窗口边框
    window_frame = {
        border_left_width    = '1px',
        border_right_width   = '1px',
        border_top_height    = '1px',
        border_bottom_height = '1px',

        border_left_color    = 'rgba(255,255,255,0.08)',
        border_right_color   = 'rgba(255,255,255,0.08)',
        border_top_color     = 'rgba(255,255,255,0.08)',
        border_bottom_color  = 'rgba(255,255,255,0.08)',
    },
    background = wallpaper.get_background_config(background_options),
}
