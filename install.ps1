param(
  [string]$RepoUrl = $env:REPO_URL
)

if (-not $RepoUrl -or $RepoUrl.Trim() -eq "") {
  $RepoUrl = "https://github.com/MuShan-bit/wezterm-config.git"
}

$HomeDir = $HOME
$ConfigDir = Join-Path $HomeDir ".config"
$TargetDir = Join-Path $ConfigDir "wezterm"

function Install-WezTerm {
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id WezTerm.WezTerm -e --silent | Out-Null
    return
  }
  if (Get-Command scoop -ErrorAction SilentlyContinue) {
    scoop install wezterm
    return
  }
  if (Get-Command choco -ErrorAction SilentlyContinue) {
    choco install wezterm -y
    return
  }
  Write-Host "Install WezTerm from https://wezfurlong.org/wezterm/index.html"
}

function Install-NerdFont {
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id NerdFonts.FiraCode -e --silent | Out-Null
    return
  }
  Write-Host "Install FiraCode Nerd Font from https://www.nerdfonts.com/"
}

function Ensure-Git {
  if (Get-Command git -ErrorAction SilentlyContinue) { return }
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id Git.Git -e --silent | Out-Null
  }
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "git is required to clone the config"
    exit 1
  }
}

Install-WezTerm
Install-NerdFont
Ensure-Git

if (-not (Test-Path $ConfigDir)) { New-Item -ItemType Directory -Path $ConfigDir | Out-Null }

if (Test-Path $TargetDir) {
  $ts = Get-Date -Format "yyyyMMddHHmmss"
  Move-Item -Path $TargetDir -Destination "$TargetDir.bak-$ts"
}

git clone $RepoUrl $TargetDir
Write-Host "Installed WezTerm config to $TargetDir"
