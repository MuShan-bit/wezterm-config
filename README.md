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
- 在 macOS 通过 Homebrew 安装 WezTerm，并安装 FiraCode Nerd Font。
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

- 字体与主题：使用 `FiraCode Nerd Font` 与 `Catppuccin Mocha` 主题，兼具可读性与美观。
- 窗口与渲染：半透明背景、macOS 毛玻璃、可调窗口装饰与内边距，超大初始视野。
- 标签与状态信息：集成 Tabline 插件，显示工作区、CPU/RAM、时间、电池与域信息。
- 启动菜单与默认 Shell：按操作系统设置默认 Shell，并提供常用 Shell/远程 SSH 启动项。
- 跨平台绑定：根据平台自动加载快捷键方案；Linux 保留 Wezterm 默认快捷键。

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
- 启动菜单：`Bash` 与统一的远程 SSH 项。

### Leader 键

- 预留 `Ctrl+Shift+Space` 作为 Leader 键，当前未绑定具体操作。

### 默认 Shell 与启动菜单

| 操作系统 | 默认 Shell | 启动菜单项 |
| --- | --- | --- |
| Windows | `pwsh.exe` | PowerShell v1 / PowerShell v7 / Cmd |
| macOS | `/usr/bin/env zsh --login` | Bash / Zsh |
| Linux | `bash` | Bash |

> 远程 SSH：支持通过启动菜单添加自定义条目（例如 `ssh <host>`）。

## 依赖与插件

| 名称 | 类型 | 作用 | 源链接 |
| --- | --- | --- | --- |
| WezTerm Tabline | WezTerm 插件 | 在标签栏显示工作区、CPU/RAM、时间、电池、域等信息 | https://github.com/michaelbrusegard/tabline.wez |
| FiraCode Nerd Font | 字体 | 提供编程连字与 Nerd Font 图标支持 | https://www.nerdfonts.com/ |
| Catppuccin for WezTerm | 颜色主题 | 提供 Catppuccin Mocha 等配色方案 | https://github.com/catppuccin/wezterm |

## 效果图


![效果图](./image/01.png)
