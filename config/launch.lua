local platform = require("utils/platform")

local options = {
    default_prog = {},
    launch_menu = {},
}

if platform.is_win then
    options.default_prog = { "pwsh.exe" }
    options.launch_menu = {
        { label = " PowerShell v1", args = { "powershell" } },
        { label = " PowerShell v7", args = { "pwsh" } },
        { label = " Cmd", args = { "cmd" } },
    }
elseif platform.is_mac then
    options.default_prog = { "zsh" }
    options.launch_menu = {
        { label = " Bash", args = { "bash" } },
        { label = " Zsh", args = { "zsh" } },
    }
elseif platform.is_linux then
    options.default_prog = { "bash" }
    options.launch_menu = {
        { label = " Bash", args = { "bash" } },
    }
end

-- 远程连接配置填充
table.insert(options.launch_menu, { label = "ALiYun-Debian", args = { "ssh", "ALiYun" } })

return options