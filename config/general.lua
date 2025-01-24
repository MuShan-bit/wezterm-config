local wezterm = require("wezterm")

return {
    -- 添加字体目录
    font_dirs = { wezterm.config_dir .. "/fonts" },
    -- 设置字体
    font_size = 16,
    font = wezterm.font("FiraCode Nerd Font"),
    -- 设置颜色主题
    color_scheme = 'catppuccin-mocha',
    -- 设置tab栏
    use_fancy_tab_bar = false,
    tab_max_width = 25,
    -- 隐藏tab栏下标
    show_tab_index_in_tab_bar = false,
    --  设置窗口样式
    window_decorations = "RESIZE",
    window_background_opacity = 0.9,
    text_background_opacity = 0.9,
    -- 防止放大缩小字体时窗口大小变化
    adjust_window_size_when_changing_font_size = false,
    -- 设置内边距
    window_padding = {
        right = 20,
        top = 20,
        bottom = 20,
    },
    -- 初始状态窗口大小
    initial_rows = 20,
    initial_cols = 80,
    -- 禁用滚动条
    enable_scroll_bar = false,
}
