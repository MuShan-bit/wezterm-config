# Wezterm Configuration

Language: English | [中文](./README.md)

Supports Windows / macOS / Linux

## Quick Start

### One-command install (recommended)

```shell
curl -fsSL https://raw.githubusercontent.com/MuShan-bit/wezterm-config/main/install.sh | bash
```

Or run locally in repo root:

```shell
bash install.sh
```

The script will:
- On macOS, install WezTerm via Homebrew and additionally install FiraCode Nerd Font.
- On Linux, prefer Flatpak or Snap to install WezTerm; otherwise follow the official guide.
- Backup existing `~/.config/wezterm` to `~/.config/wezterm.bak-<timestamp>` and clone this config.

#### Windows (PowerShell)

Run in PowerShell:

```powershell
iwr -useb https://raw.githubusercontent.com/MuShan-bit/wezterm-config/main/install.ps1 | iex
```

Or from repo root:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

### Manual install

1. Install WezTerm: <https://wezfurlong.org/wezterm/index.html>
2. Clone config:

```shell
mkdir -p ~/.config
git clone https://github.com/MuShan-bit/wezterm-config.git ~/.config/wezterm
```

## Features Overview

- Fonts & Theme: bundled `Maple Mono NF CN` with the `Catppuccin Mocha` theme. Launch-menu labels are plain text so they remain readable when a system font lacks Nerd Font glyphs.
- Window & Rendering: a translucent black background by default, macOS blur, thin borders, and cell-based padding. The initial terminal grid is `200 x 35`, and font resizing does not resize the window.
- Tabs & Status: Tabline plugin showing workspace, CPU/RAM, datetime, battery, and domain.
- Launch Menu & Default Shell: per-OS defaults with common shells and automatically generated SSH entries.
- Cross-Platform Bindings: platform-specific keymaps; Linux keeps WezTerm defaults.

### Configuration Layout

`wezterm.lua` merges these modules, then loads the plugins:

| Location | Contents |
| --- | --- |
| `config/general.lua` | Font, theme, window, tab bar, and background |
| `config/launch.lua` | Per-platform default shell and local launch-menu entries |
| `config/bindings/` | macOS, Windows, and shared mouse bindings |
| `config/wallpaper.lua` | Background modes, random-wallpaper scan, and fallback logic |
| `plugins/` | Tabline and SSH launch-menu plugins |

### Background Styles

Transparent mode is enabled by default: a black overlay sits over the translucent window (background-layer `opacity = 0.7`; `window_background_opacity = 0.5`). Change `background` in `config/general.lua` to select another mode.

| Mode | Option | Result |
| --- | --- | --- |
| `wallpaper.modes.transparent` | None | Fixed black overlay with `opacity = 0.7` |
| `wallpaper.modes.solid` | `color` | Solid colour background |
| `wallpaper.modes.fixed` | `path` | One image background |
| `wallpaper.modes.random` | `path` | Random image from a directory |

```lua
-- config/general.lua
background = wallpaper.get_background_config({
    mode = wallpaper.modes.fixed,
    path = wezterm.config_dir .. "/background/night.png",
})
```

For random mode, `path` is an image directory and defaults to `background/random`. The scan supports `jpg`, `jpeg`, `png`, and `webp`, including images in subdirectories. Missing fixed images, empty random directories, and unknown modes fall back to the black overlay.

```lua
-- Pick a wallpaper from the default directory
background = wallpaper.get_background_config({
    mode = wallpaper.modes.random,
})

-- Use a solid background colour
background = wallpaper.get_background_config({
    mode = wallpaper.modes.solid,
    color = "#1e1e2e",
})
```

### SSH Remote Connections

The SSH plugin is enabled by default. It reads `~/.ssh/config`, including files referenced by `Include`, and adds valid `Host` aliases to the launch menu. Selecting `SSH: <host>` opens a new remote-connection tab. Wildcard rules such as `Host *` are not listed.

Set either `ssh` or `tabline` to `false` in `enabled_plugins` in `plugins/init.lua` to disable that plugin.

## Shortcuts

### macOS (custom)

| Shortcut | Action |
| --- | --- |
| `Cmd+n` | New window |
| `Cmd+t` | New tab |
| `Cmd+w` | Close current tab (no confirm) |
| `Cmd+r` | Reload configuration |
| `Cmd+1..9` | Activate tab N |
| `Cmd+[` / `Cmd+]` | Previous / Next tab |
| `Cmd+d` | Split pane horizontally |
| `Cmd+Shift+d` | Split pane vertically |
| `Cmd+←/→/↑/↓` | Activate adjacent pane |
| `Cmd+c` / `Cmd+v` | Copy / Paste |
| `Cmd+=` / `Cmd++` / `Cmd-` / `Cmd+0` | Font size up / down / reset |
| `Cmd+f` | Search |
| `Cmd+Shift+k/j` | Scroll by line (up/down) |
| `Cmd+PageUp/PageDown` | Scroll by page (up/down) |
| `Cmd+q` | Quit |
| Mouse: `Ctrl+Click` | Open link; drag/double/triple click to select |

### Windows (custom)

| Shortcut | Action |
| --- | --- |
| `F11` | Toggle full screen |
| `Ctrl+Shift+Tab` | Cycle tabs (forward) |
| `Ctrl+Shift+N` | New window |
| `Ctrl+Shift+T` | Show launcher |
| `Ctrl+Shift+Enter` | Launcher with fuzzy/tabs/menu items |
| `Ctrl+Shift+C` / `Ctrl+Shift+V` | Copy / Paste |
| `Ctrl+Shift+W` | Close current tab (no confirm) |
| `Ctrl+Shift++` / `Ctrl+Shift+-` | Font size up / down |
| `Ctrl+Shift+PageUp/PageDown` | Scroll by page (up/down) |
| `Ctrl+Shift+↑/↓` | Scroll by line (up/down) |
| Mouse: `Ctrl+Click` | Open link; drag/double/triple click to select |

### Linux (default)

- Shortcuts: use WezTerm defaults (not overridden).
- Default shell: `bash`.
- Launch menu: `Bash` plus remote SSH entries discovered from `~/.ssh/config`.

## Leader Key

- `Ctrl+Shift+Space` reserved as the leader key; currently not bound.

## Default Shell & Launch Menu

| OS | Default Shell | Launch Menu |
| --- | --- | --- |
| Windows | `pwsh.exe` | PowerShell v1 / PowerShell v7 / Cmd |
| macOS | `/usr/bin/env zsh --login` | Bash / Zsh |
| Linux | `bash` | Bash |

> Remote SSH: Host aliases from `~/.ssh/config` are shown automatically in the launch menu.

## Fonts, Dependencies & Plugins

| Name | Type | Purpose | Link |
| --- | --- | --- | --- |
| WezTerm Tabline | WezTerm plugin | Status/tabline with workspace, CPU/RAM, time, battery, domain | https://github.com/michaelbrusegard/tabline.wez |
| Maple Mono NF CN | Bundled font | Current terminal font, including Chinese and Nerd Font glyphs | `fonts/Maple Mono NF CN/` |
| FiraCode Nerd Font | Optional system font | The one-command installer attempts to install it; it is not the configured primary font | https://www.nerdfonts.com/ |
| Catppuccin for WezTerm | Color theme | Catppuccin Mocha palette for WezTerm | https://github.com/catppuccin/wezterm |

## Screenshot

![Screenshot](./image/01.png)
