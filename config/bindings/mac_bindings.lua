local act = require("wezterm").action

local keys = {
    -- 新建窗口
    { key = "n",          mods = "CMD",       action = act.SpawnWindow },
    -- 新建标签页
    { key = "t",          mods = "CMD",       action = act.SpawnTab("DefaultDomain") },
    -- 关闭当前标签页
    { key = "w",          mods = "CMD",       action = act.CloseCurrentTab { confirm = false } },
    -- 重新加载配置
    { key = "r",          mods = "CMD",       action = act.ReloadConfiguration },

    -- 切换到第 1~9 标签页
    { key = "1",          mods = "CMD",       action = act.ActivateTab(0) },
    { key = "2",          mods = "CMD",       action = act.ActivateTab(1) },
    { key = "3",          mods = "CMD",       action = act.ActivateTab(2) },
    { key = "4",          mods = "CMD",       action = act.ActivateTab(3) },
    { key = "5",          mods = "CMD",       action = act.ActivateTab(4) },
    { key = "6",          mods = "CMD",       action = act.ActivateTab(5) },
    { key = "7",          mods = "CMD",       action = act.ActivateTab(6) },
    { key = "8",          mods = "CMD",       action = act.ActivateTab(7) },
    { key = "9",          mods = "CMD",       action = act.ActivateTab(8) },
    -- 上一个/下一个标签页
    { key = "[",          mods = "CMD",       action = act.ActivateTabRelative(-1) },
    { key = "]",          mods = "CMD",       action = act.ActivateTabRelative(1) },
    -- 水平/垂直拆分窗格
    { key = "d",          mods = "CMD",       action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "d",          mods = "CMD|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    -- 激活上下左右窗格
    { key = "LeftArrow",  mods = "CMD",       action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "CMD",       action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow",    mods = "CMD",       action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow",  mods = "CMD",       action = act.ActivatePaneDirection("Down") },
    -- 复制/粘贴
    { key = "c",          mods = "CMD",       action = act.CopyTo("Clipboard") },
    { key = "v",          mods = "CMD",       action = act.PasteFrom("Clipboard") },
    -- 字体缩放
    { key = "=",          mods = "CMD",       action = act.IncreaseFontSize },
    { key = "+",          mods = "CMD",       action = act.IncreaseFontSize },
    { key = "-",          mods = "CMD",       action = act.DecreaseFontSize },
    { key = "0",          mods = "CMD",       action = act.ResetFontSize },
    -- 搜索
    { key = "f",          mods = "CMD",       action = act.Search("CurrentSelectionOrEmptyString") },
    -- 滚动一行/一页
    { key = "k",          mods = "CMD|SHIFT", action = act.ScrollByLine(-1) },
    { key = "j",          mods = "CMD|SHIFT", action = act.ScrollByLine(1) },
    { key = "PageUp",     mods = "CMD",       action = act.ScrollByPage(-1) },
    { key = "PageDown",   mods = "CMD",       action = act.ScrollByPage(1) },
    -- 调试与退出
    { key = "x",          mods = "CMD|SHIFT", action = act.ShowDebugOverlay },
    { key = "q",          mods = "CMD|SHIFT", action = act.QuitApplication },
}

local mouse_bindings = {
    -- 按住 Ctrl 键单击将打开鼠标光标下的链接
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
    -- 移动鼠标只会选择文本而不会将文本复制到剪贴板
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.SelectTextAtMouseCursor("Cell"),
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.ExtendSelectionToMouseCursor("Cell"),
    },
    {
        event = { Drag = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.ExtendSelectionToMouseCursor("Cell"),
    },
    -- 左键单击三次将选择一行
    {
        event = { Down = { streak = 3, button = "Left" } },
        mods = "NONE",
        action = act.SelectTextAtMouseCursor("Line"),
    },
    {
        event = { Up = { streak = 3, button = "Left" } },
        mods = "NONE",
        action = act.SelectTextAtMouseCursor("Line"),
    },
    -- 双击左键将选择一个单词
    {
        event = { Down = { streak = 2, button = "Left" } },
        mods = "NONE",
        action = act.SelectTextAtMouseCursor("Word"),
    },
    {
        event = { Up = { streak = 2, button = "Left" } },
        mods = "NONE",
        action = act.SelectTextAtMouseCursor("Word"),
    },
    -- 打开鼠标滚轮来滚动屏幕
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "NONE",
        action = act.ScrollByCurrentEventWheelDelta,
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "NONE",
        action = act.ScrollByCurrentEventWheelDelta,
    },
}

return {
    disable_default_key_bindings = true,
    disable_default_mouse_bindings = true,
    leader = { key = "Space", mods = "CTRL|SHIFT" },
    keys = keys,
    mouse_bindings = mouse_bindings,
}
