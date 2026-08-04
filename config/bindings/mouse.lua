local act = require("wezterm").action

return {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
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
