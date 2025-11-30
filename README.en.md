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
- On macOS, install WezTerm via Homebrew and install FiraCode Nerd Font.
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

- Fonts & Theme: `FiraCode Nerd Font` with `Catppuccin Mocha` for readability and aesthetics.
- Window & Rendering: translucent background, macOS blur, adjustable decorations and padding, large initial viewport.
- Tabs & Status: Tabline plugin showing workspace, CPU/RAM, datetime, battery, and domain.
- Launch Menu & Default Shell: per-OS defaults with common shells; remote SSH entries can be added.
- Cross-Platform Bindings: platform-specific keymaps; Linux keeps WezTerm defaults.

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
- Launch menu: `Bash` and add your own remote SSH entries as needed.

## Leader Key

- `Ctrl+Shift+Space` reserved as the leader key; currently not bound.

## Default Shell & Launch Menu

| OS | Default Shell | Launch Menu |
| --- | --- | --- |
| Windows | `pwsh.exe` | PowerShell v1 / PowerShell v7 / Cmd |
| macOS | `/usr/bin/env zsh --login` | Bash / Zsh |
| Linux | `bash` | Bash |

> Remote SSH: add your own items via the launch menu (e.g., `ssh <host>`). Non-general examples are omitted.

## Dependencies & Plugins

| Name | Type | Purpose | Link |
| --- | --- | --- | --- |
| WezTerm Tabline | WezTerm plugin | Status/tabline with workspace, CPU/RAM, time, battery, domain | https://github.com/michaelbrusegard/tabline.wez |
| FiraCode Nerd Font | Font | Programming ligatures and Nerd Font icons | https://www.nerdfonts.com/ |
| Catppuccin for WezTerm | Color theme | Catppuccin Mocha palette for WezTerm | https://github.com/catppuccin/wezterm |

## Screenshot

![Screenshot](./image/01.png)
