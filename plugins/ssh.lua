local wezterm = require("wezterm")

local M = {}

local home_dir = wezterm.home_dir or os.getenv("HOME") or ""

local DEFAULTS = {
    config_path = home_dir .. "/.ssh/config",
    label_prefix = "SSH: ",
    enabled = true,
}

local function trim(value)
    return value:match("^%s*(.-)%s*$")
end

local function dirname(path)
    return path:match("^(.*)[/\\]") or "."
end

local function file_exists(path)
    local file = io.open(path, "r")
    if not file then
        return false
    end

    file:close()
    return true
end

local function expand_path(path, base_dir)
    path = trim(path)
    if path:sub(1, 2) == "~/" then
        return home_dir .. path:sub(2)
    end

    if path:sub(1, 1) == "/" or path:match("^%a:[/\\]") then
        return path
    end

    return base_dir .. "/" .. path
end

local function resolve_include_paths(pattern, base_dir)
    local path = expand_path(pattern, base_dir)
    if not path:find("[%*%?%[]") then
        return file_exists(path) and { path } or {}
    end

    if not wezterm.glob then
        wezterm.log_warn("当前 WezTerm 版本不支持 SSH Include 通配符：" .. path)
        return {}
    end

    return wezterm.glob(path)
end

local function is_host_alias(host)
    return host ~= ""
        and not host:find("[%*%!%?]")
        and host:sub(1, 1) ~= "-"
end

local function add_hosts(hosts, seen_hosts, value)
    for host in value:gmatch("%S+") do
        host = host:gsub('^"(.*)"$', "%1")
        if is_host_alias(host) and not seen_hosts[host] then
            seen_hosts[host] = true
            table.insert(hosts, host)
        end
    end
end

local function parse_file(path, hosts, seen_hosts, seen_files)
    if seen_files[path] then
        return
    end
    seen_files[path] = true

    local file = io.open(path, "r")
    if not file then
        return
    end

    local base_dir = dirname(path)
    for line in file:lines() do
        line = line:gsub("%s+#.*$", "")
        local keyword, value = line:match("^%s*([^%s=]+)%s*=?%s*(.-)%s*$")
        keyword = keyword and keyword:lower()

        if keyword == "host" then
            add_hosts(hosts, seen_hosts, value)
        elseif keyword == "include" then
            for pattern in value:gmatch("%S+") do
                for _, include_path in ipairs(resolve_include_paths(pattern, base_dir)) do
                    parse_file(include_path, hosts, seen_hosts, seen_files)
                end
            end
        end
    end

    file:close()
end

function M.get_hosts(config_path)
    local hosts = {}
    parse_file(config_path or DEFAULTS.config_path, hosts, {}, {})
    return hosts
end

local function has_launch_entry(launch_menu, host)
    for _, entry in ipairs(launch_menu) do
        if entry.args and entry.args[1] == "ssh" and entry.args[2] == host then
            return true
        end
    end

    return false
end

function M.setup(config, options)
    options = options or {}
    if options.enabled == false then
        return
    end

    local config_path = options.config_path or DEFAULTS.config_path
    local label_prefix = options.label_prefix or DEFAULTS.label_prefix
    config.launch_menu = config.launch_menu or {}

    for _, host in ipairs(M.get_hosts(config_path)) do
        if not has_launch_entry(config.launch_menu, host) then
            table.insert(config.launch_menu, {
                label = label_prefix .. host,
                args = { "ssh", host },
            })
        end
    end
end

return M
