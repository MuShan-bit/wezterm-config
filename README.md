# Wezterm 配置

语言切换： [English](./README.en.md) | 中文

支持 Windows / Mac / Linux

## 快速开始

### 一键安装（推荐）

```shell
curl -fsSL https://raw.githubusercontent.com/MuShan-bit/wezterm-config/main/install.sh | bash
```

或在本仓库根目录执行：

```shell
bash install.sh
```

该脚本将：
- 在 macOS 通过 Homebrew 安装 WezTerm，并额外安装 FiraCode Nerd Font。
- 在 Linux 优先使用 Flatpak 或 Snap 安装 WezTerm；若不可用，请按官网指引手动安装。
- 备份现有 `~/.config/wezterm` 到 `~/.config/wezterm.bak-时间戳`，并克隆本配置。

#### Windows（PowerShell）

在 PowerShell 中执行：

```powershell
iwr -useb https://raw.githubusercontent.com/MuShan-bit/wezterm-config/main/install.ps1 | iex
```

或在仓库根目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

### 手动安装

1. 安装 WezTerm（官网）：<https://wezfurlong.org/wezterm/index.html>
2. 克隆配置：

```shell
mkdir -p ~/.config
git clone https://github.com/MuShan-bit/wezterm-config.git ~/.config/wezterm
```

## 功能概述

- 字体与主题：内置 `Maple Mono NF CN` 字体，并使用 `Catppuccin Mocha` 主题；启动菜单使用纯文本标签，避免系统缺少 Nerd Font 图标时显示异常。
- 窗口与渲染：默认黑色半透明背景、macOS 毛玻璃、细边框和按字符单元计算的内边距；初始终端网格为 `200 x 35`，字体缩放不会改变窗口尺寸。
- 标签与状态信息：集成 Tabline 插件，显示工作区、CPU/RAM、时间、电池与域信息。
- 启动菜单与默认 Shell：按操作系统设置默认 Shell，并自动生成 SSH 远程连接启动项。
- 跨平台绑定：根据平台自动加载快捷键方案；Linux 保留 Wezterm 默认快捷键。

### 配置结构

入口文件 `wezterm.lua` 会合并以下模块，并在最后加载插件：

| 位置 | 内容 |
| --- | --- |
| `config/general.lua` | 字体、主题、窗口、标签栏与背景 |
| `config/launch.lua` | 按平台设置默认 Shell 和本地启动菜单 |
| `config/bindings/` | macOS、Windows 和通用鼠标绑定 |
| `config/wallpaper.lua` | 背景模式、随机壁纸扫描与回退逻辑 |
| `plugins/` | Tabline 与 SSH 启动菜单插件 |

### 背景风格

默认启用透明模式：黑色遮罩叠加在半透明窗口上（背景层 `opacity = 0.7`，窗口 `window_background_opacity = 0.5`）。在 `config/general.lua` 修改 `background` 即可切换模式。

| 模式 | 配置 | 效果 |
| --- | --- | --- |
| `wallpaper.modes.transparent` | 无 | 固定黑色遮罩，`opacity = 0.7` |
| `wallpaper.modes.solid` | `color` | 纯色背景 |
| `wallpaper.modes.fixed` | `path` | 固定图像背景 |
| `wallpaper.modes.random` | `path` | 从指定目录随机选择图像背景 |

```lua
-- config/general.lua
background = wallpaper.get_background_config({
    mode = wallpaper.modes.fixed,
    path = wezterm.config_dir .. "/background/night.png",
})
```

随机模式的 `path` 是图片目录，默认使用 `background/random`。扫描支持 `jpg`、`jpeg`、`png` 和 `webp`，也会查找子目录中的图片。固定图像不存在、随机目录为空或模式无效时，会自动回退到黑色遮罩。

```lua
-- 从默认目录随机选择壁纸
background = wallpaper.get_background_config({
    mode = wallpaper.modes.random,
})

-- 使用纯色
background = wallpaper.get_background_config({
    mode = wallpaper.modes.solid,
    color = "#1e1e2e",
})
```

### SSH 远程连接

SSH 插件默认开启，会读取 `~/.ssh/config`（并解析其中的 `Include` 文件），将有效的 `Host` 别名加入启动菜单。选择 `SSH: <主机名>` 即会新建一个对应的远程连接 Tab；通配符规则（如 `Host *`）不会显示为菜单项。

在 `plugins/init.lua` 的 `enabled_plugins` 中可分别将 `ssh` 或 `tabline` 设为 `false` 来关闭对应插件。

## 快捷键

### macOS（自定义）

| 快捷键 | 动作 |
| --- | --- |
| `Cmd+n` | 新建窗口 |
| `Cmd+t` | 新建标签页 |
| `Cmd+w` | 关闭当前标签页（无确认） |
| `Cmd+r` | 重新加载配置 |
| `Cmd+1..9` | 切换至第 N 标签页 |
| `Cmd+[` / `Cmd+]` | 上/下一个标签页 |
| `Cmd+d` | 水平拆分窗格 |
| `Cmd+Shift+d` | 垂直拆分窗格 |
| `Cmd+←/→/↑/↓` | 激活相邻窗格 |
| `Cmd+c` / `Cmd+v` | 复制 / 粘贴 |
| `Cmd+=` / `Cmd++` / `Cmd-` / `Cmd+0` | 字体放大 / 缩小 / 重置 |
| `Cmd+f` | 搜索 |
| `Cmd+Shift+k/j` | 按行滚动（上/下） |
| `Cmd+PageUp/PageDown` | 按页滚动（上/下） |
| `Cmd+q` | 退出 |
| 鼠标：`Ctrl+点击` | 打开链接；拖拽/双击/三击选择 |

### Windows（自定义）

| 快捷键 | 动作 |
| --- | --- |
| `F11` | 切换全屏 |
| `Ctrl+Shift+Tab` | 遍历标签页（正向） |
| `Ctrl+Shift+N` | 新建窗口 |
| `Ctrl+Shift+T` | 打开启动器 |
| `Ctrl+Shift+Enter` | 启动器（模糊搜索/标签/菜单项） |
| `Ctrl+Shift+C` / `Ctrl+Shift+V` | 复制 / 粘贴 |
| `Ctrl+Shift+W` | 关闭当前标签页（无确认） |
| `Ctrl+Shift++` / `Ctrl+Shift+-` | 字体放大 / 缩小 |
| `Ctrl+Shift+PageUp/PageDown` | 按页滚动（上/下） |
| `Ctrl+Shift+↑/↓` | 按行滚动（上/下） |
| 鼠标：`Ctrl+点击` | 打开链接；拖拽/双击/三击选择 |

### Linux（默认）

- 快捷键：使用 Wezterm 默认快捷键，不覆盖。
- 默认 Shell：`bash`。
- 启动菜单：`Bash` 与从 `~/.ssh/config` 自动发现的远程 SSH 项。

### Leader 键

- 预留 `Ctrl+Shift+Space` 作为 Leader 键，当前未绑定具体操作。

### 默认 Shell 与启动菜单

| 操作系统 | 默认 Shell | 启动菜单项 |
| --- | --- | --- |
| Windows | `pwsh.exe` | PowerShell v1 / PowerShell v7 / Cmd |
| macOS | `/usr/bin/env zsh --login` | Bash / Zsh |
| Linux | `bash` | Bash |

> 远程 SSH：启动菜单会自动显示 `~/.ssh/config` 中的 Host 别名。

## 字体、依赖与插件

| 名称 | 类型 | 作用 | 源链接 |
| --- | --- | --- | --- |
| WezTerm Tabline | WezTerm 插件 | 在标签栏显示工作区、CPU/RAM、时间、电池、域等信息 | https://github.com/michaelbrusegard/tabline.wez |
| Maple Mono NF CN | 内置字体 | 当前终端字体，包含中文与 Nerd Font 图标字形 | `fonts/Maple Mono NF CN/` |
| FiraCode Nerd Font | 可选系统字体 | 一键安装脚本会尝试安装；当前配置不将其作为主字体 | https://www.nerdfonts.com/ |
| Catppuccin for WezTerm | 颜色主题 | 提供 Catppuccin Mocha 等配色方案 | https://github.com/catppuccin/wezterm |

## 效果图


![效果图](./image/01.png)
