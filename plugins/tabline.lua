local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local table_utils = require("utils.table_utils")

local default_config = {
    options = {
        icons_enabled = true,
        theme = 'Catppuccin Mocha',
        tabs_enabled = true,
        theme_overrides = {},
        section_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider,
        },
        component_separators = {
            left = wezterm.nerdfonts.pl_left_soft_divider,
            right = wezterm.nerdfonts.pl_right_soft_divider,
        },
        tab_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider,
        },
    },
    sections = {
        tabline_a = { 'mode' },
        tabline_b = { 'workspace' },
        tabline_c = { ' ' },
        tab_active = {
            'index',
            { 'parent', padding = 0 },
            '/',
            { 'cwd',    padding = { left = 0, right = 1 } },
            { 'zoomed', padding = 0 },
        },
        tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
        tabline_x = { 'ram', 'cpu' },
        tabline_y = { 'datetime', 'battery' },
        tabline_z = { 'domain' },
    },
    extensions = {},
}

local function setup(user_config)
    local final_config = {}
    table_utils.merge_tables(final_config, default_config)
    if user_config then
        table_utils.merge_tables(final_config, user_config)
    end
    return tabline.setup(final_config)
end

return {
    setup = setup
}
