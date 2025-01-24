local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- 设置启动程序
config.default_prog = {
    "pwsh"
}

-- 启动菜单的一些启动项
config.launch_menu = {
    { label = 'PowerShell',    args = { 'pwsh.exe' }, },
    { label = 'CMD',           args = { 'cmd.exe' }, },
    { label = 'ALiYun-Debian', args = { 'ssh', "ALiYun" }, },
}

-- 设置字体
config.font_size = 16
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
-- 设置颜色主题
config.color_scheme = 'Catppuccin Mocha'
-- 设置tab栏
config.use_fancy_tab_bar = false
config.tab_max_width = 25
-- 隐藏tab栏下标
config.show_tab_index_in_tab_bar = false

config.window_decorations = "RESIZE"
-- 设置窗口样式
config.window_background_opacity = 0.9
config.text_background_opacity = 0.9
-- 防止放大缩小字体时窗口大小变化
config.adjust_window_size_when_changing_font_size = false
-- 设置内边距
config.window_padding = {
    right = 20,
    top = 20,
    bottom = 20,
}
-- 初始状态窗口大小
config.initial_rows = 20
config.initial_cols = 80
-- 禁用滚动条
config.enable_scroll_bar = false


-- 取消所有默认的热键
config.disable_default_key_bindings = true
local act = wezterm.action
config.keys = {
    -- Ctrl+Shift+Tab 遍历 tab
    { key = 'Tab',       mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
    -- F11 切换全屏
    { key = 'F11',       mods = 'NONE',       action = act.ToggleFullScreen },
    -- Ctrl+Shift++ 字体增大
    { key = '+',         mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    -- Ctrl+Shift+- 字体减小
    { key = '_',         mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    -- Ctrl+Shift+C 复制选中区域
    { key = 'C',         mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    -- Ctrl+Shift+N 新窗口
    { key = 'N',         mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    -- Ctrl+Shift+T 新 tab
    { key = 'T',         mods = 'SHIFT|CTRL', action = act.ShowLauncher },
    -- Ctrl+Shift+Enter 显示启动菜单
    { key = 'Enter',     mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
    -- Ctrl+Shift+V 粘贴剪切板的内容
    { key = 'V',         mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    -- Ctrl+Shift+W 关闭 tab 且不进行确认
    { key = 'W',         mods = 'SHIFT|CTRL', action = act.CloseCurrentTab { confirm = false } },
    -- Ctrl+Shift+PageUp 向上滚动一页
    { key = 'PageUp',    mods = 'SHIFT|CTRL', action = act.ScrollByPage(-1) },
    -- Ctrl+Shift+PageDown 向下滚动一页
    { key = 'PageDown',  mods = 'SHIFT|CTRL', action = act.ScrollByPage(1) },
    -- Ctrl+Shift+UpArrow 向上滚动一行
    { key = 'UpArrow',   mods = 'SHIFT|CTRL', action = act.ScrollByLine(-1) },
    -- Ctrl+Shift+DownArrow 向下滚动一行
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(1) },
    -- Ctrl+小键盘1 访问AliYun服务器
    {
        key = '1',
        mods = 'CTRL',
        action = act.SpawnCommandInNewTab {
            args = { 'ssh', 'ALiYun' },
        }
    },
}

return config
