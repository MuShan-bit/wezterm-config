#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/MuShan-bit/wezterm-config.git}"
CONFIG_DIR="${HOME}/.config"
TARGET_DIR="${CONFIG_DIR}/wezterm"

os="$(uname -s)"

install_wezterm_macos() {
  if command -v brew >/dev/null 2>&1; then
    brew install --cask wezterm || true
    brew tap homebrew/cask-fonts >/dev/null 2>&1 || true
    brew install --cask font-fira-code-nerd-font || true
  else
    echo "Homebrew not found. Install WezTerm from https://wezfurlong.org/wezterm/index.html"
  fi
}

install_wezterm_linux() {
  if command -v flatpak >/dev/null 2>&1; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true
    flatpak install -y flathub org.wezfurlong.wezterm || true
  elif command -v snap >/dev/null 2>&1; then
    sudo snap install wezterm || true
  else
    echo "Install WezTerm from https://wezfurlong.org/wezterm/index.html"
  fi
}

install_wezterm_windows() {
  echo "Install WezTerm from https://wezfurlong.org/wezterm/index.html"
}

case "$os" in
  Darwin) install_wezterm_macos ;;
  Linux) install_wezterm_linux ;;
  MINGW*|MSYS*|CYGWIN*) install_wezterm_windows ;;
  *) echo "Unsupported OS" ;;
esac

mkdir -p "$CONFIG_DIR"

if [ -d "$TARGET_DIR" ]; then
  ts=$(date +%Y%m%d%H%M%S)
  mv "$TARGET_DIR" "${TARGET_DIR}.bak-${ts}"
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git is required to clone the config"
  exit 1
fi

git clone "$REPO_URL" "$TARGET_DIR"

echo "Installed WezTerm config to $TARGET_DIR"
