package.path = "./?.lua;./?/init.lua;" .. package.path

package.preload["wezterm"] = function()
    return {
        home_dir = "/tmp",
        glob = function()
            return {}
        end,
        log_warn = function() end,
    }
end

local ssh = require("plugins.ssh")

local fixture_dir = os.tmpname()
os.remove(fixture_dir)
assert(os.execute("mkdir -p " .. fixture_dir) == true)

local config = assert(io.open(fixture_dir .. "/config", "w"))
config:write("Host production staging *.internal !excluded\n")
config:write("  HostName example.test\n")
config:write("Include included.conf\n")
config:close()

local included = assert(io.open(fixture_dir .. "/included.conf", "w"))
included:write("Host staging development\n")
included:close()

local hosts = ssh.get_hosts(fixture_dir .. "/config")
assert(table.concat(hosts, ",") == "production,staging,development")

local wezterm_config = { launch_menu = {} }
ssh.setup(wezterm_config, { config_path = fixture_dir .. "/config" })
assert(#wezterm_config.launch_menu == 3)
assert(wezterm_config.launch_menu[1].label == "SSH: production")
assert(wezterm_config.launch_menu[1].args[2] == "production")

os.remove(fixture_dir .. "/config")
os.remove(fixture_dir .. "/included.conf")
assert(os.remove(fixture_dir))
