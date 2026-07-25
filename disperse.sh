#!/bin/bash

# Creates symlinks from repo into their default locations in `~` and `~/.config`.

OS=$(uname)
HOME_CONFIG="$HOME/.config" # MacOS and Linux
APP_SUPPORT="$HOME/Library/Application Support" # MacOS only
LOCAL_PATH="$(dirname "$(realpath "$0")")" # path for script directory

# Local config locations
SHARED_CONFIGS="$LOCAL_PATH/configs/shared"
MAC_CONFIGS="$LOCAL_PATH/configs/mac"
LINUX_CONFIGS="$LOCAL_PATH/configs/linux"

# Links a source to a destination and handles edge cases
function try_link() {
    configName=$1
    sourcePath=$2
    destinationPath=$3

    if [[ ! -f "$sourcePath" && ! -d "$sourcePath" ]]; then
        echo "Config for $configName not found in repo."
        return 1
    fi

    if [ ! -e "$destinationPath" ]; then
        ln -s "$sourcePath" "$destinationPath"
        echo "Config for $configName was symlinked to $destinationPath."
    elif [ -L "$destinationPath" ]; then
        rm "$destinationPath"
        ln -s "$sourcePath" "$destinationPath"
        echo "Overwrote config symlink for $configName at $destinationPath"
    elif [ -f "$destinationPath" ]; then
        mv "$destinationPath" "$destinationPath.bak"
        ln -s "$sourcePath" "$destinationPath"
        echo "Expected symlink path for $configName already has a file. Moved file to $destinationPath.bak and replaced with symlink."
    elif [ -d destinationPath ]; then
        echo "Expected symlink path for $configName is a directory ($destinationPath). Move it to allow a symlink to take its place."
    fi
}

# Creates dir path for configs
function create_path() {
    configName=$1
    destinationPath=$2

    if [ ! -e "$destinationPath" ]; then
        mkdir -p "$destinationPath"
        echo "Created config dir path for $configName: $destinationPath"
    fi
}

echo "Linking files from repo in $LOCAL_PATH..."
echo

# --------------------------------------------------
# Shared configs
# These go to the same place in both MacOS and Linux.
# --------------------------------------------------

# zellij
create_path "zellij" "$HOME_CONFIG/zellij"
try_link "Zellij" "$SHARED_CONFIGS/zellij.kdl" "$HOME_CONFIG/zellij/config.kdl"

# Wezterm
try_link "Wezterm" "$SHARED_CONFIGS/wezterm" "$HOME_CONFIG/wezterm"

# Starship
try_link "Starship" "$SHARED_CONFIGS/starship.toml" "$HOME_CONFIG/starship.toml"

# Btop
create_path "btop" "$HOME_CONFIG/btop"
try_link "Btop++" "$SHARED_CONFIGS/btop.conf" "$HOME_CONFIG/btop/btop.conf"

# OpenCode
create_path "opencode" "$HOME_CONFIG/opencode"
create_path "opencode themes" "$HOME_CONFIG/opencode/themes"
try_link "opencode" "$SHARED_CONFIGS/opencode/opencode.jsonc" "$HOME_CONFIG/opencode/opencode.jsonc"
try_link "opencode tui config" "$SHARED_CONFIGS/opencode/tui.jsonc" "$HOME_CONFIG/opencode/tui.jsonc"
try_link "opencode kanagawa custom theme" "$SHARED_CONFIGS/opencode/kanagawa-custom.json" "$HOME_CONFIG/opencode/themes/kanagawa-custom.json"
try_link "opencode AGENTS.md" "$SHARED_CONFIGS/opencode/AGENTS.md" "$HOME_CONFIG/opencode/themes/AGENTS.md"

# Bat
try_link "bat" "$SHARED_CONFIGS/bat" "$HOME_CONFIG/bat"

# Link ripgrep ignore config
try_link "Ripgrep Ignore" "$SHARED_CONFIGS/ripgrep.ignore" "$HOME_CONFIG/ripgrep.ignore"

# --------------------------------------------------
# MacOS configs
# --------------------------------------------------

if [[ "$OS" == "Darwin" ]]; then
    # Mise
    try_link "Mise" "$MAC_CONFIGS/mise" "$HOME_CONFIG/mise"

    # Ghostty
    try_link "Ghostty" "$MAC_CONFIGS/ghostty" "$APP_SUPPORT/com.mitchellh.ghostty"

    # k9s - Shared config file, but different locations per platform
    create_path "k9s" "$APP_SUPPORT/k9s"
    try_link "k9s config" "$SHARED_CONFIGS/k9s/config.yaml" "$APP_SUPPORT/k9s/config.yaml"
    try_link "k9s skins" "$SHARED_CONFIGS/k9s/skins" "$APP_SUPPORT/k9s/skins"

    # Lazygit - Shared config file, but different locations per platform
    create_path "k9s" "$APP_SUPPORT/lazygit"
    try_link "Lazygit" "$MAC_CONFIGS/lazygit.yml" "$APP_SUPPORT/lazygit/config.yml"

    # IdeaVim
    try_link "IdeaVim" "$SHARED_CONFIGS/ideavimrc" "$HOME/.ideavimrc"
fi

# --------------------------------------------------
# Linux configs
# --------------------------------------------------

if [[ "$OS" == "Linux" ]]; then
    # systemd custom services
    try_link "systemd services" "$LINUX_CONFIGS/systemd" "$HOME_CONFIG/systemd"

    # Ghostty
    try_link "Ghostty" "$LINUX_CONFIGS/ghostty-linux" "$HOME_CONFIG/ghostty"

    # k9s - Shared config file, but different locations per platform
    create_path "k9s" "$HOME_CONFIG/k9s"
    try_link "k9s config" "$SHARED_CONFIGS/k9s/config.yaml" "$HOME_CONFIG/k9s/config.yaml"
    try_link "k9s skins" "$SHARED_CONFIGS/k9s/skins" "$HOME_CONFIG/k9s/skins"

    # Lazygit - Shared config file, but different locations per platform
    create_path "Lazygit" "$HOME_CONFIG/lazygit"
    try_link "Lazygit" "$SHARED_CONFIGS/lazygit.yml" "$HOME_CONFIG/lazygit/config.yml"

    # Hyprland and hypr configs
    try_link "Hypr config" "$LINUX_CONFIGS/hypr" "$HOME_CONFIG/hypr"

    # Link custom binaries/scripts
    create_path "~/bin" "$HOME/bin"
    try_link "hyprscope (gamescope/hyprland util)" "$LINUX_CONFIGS/hypr/scripts/hyprscope/hyprscope.sh" "$HOME/bin/hyprscope"
fi
