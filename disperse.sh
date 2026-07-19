#!/bin/bash

# Creates symlinks from repo into their default locations in `~` and `~/.config`.

OS=$(uname)
CONFIG_DIR="$HOME/.config"
APP_SUPPORT_DIR="$HOME/Library/Application Support"
LOCAL_PATH="$(dirname "$(realpath "$0")")" # path for script directory

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

echo "Linking files from repo at path $LOCAL_PATH..."
echo

# --------------------------------------------------
# MacOS / Linux univeral install locations
# --------------------------------------------------

# mise config
try_link "Mise" "$LOCAL_PATH/configs/mise" "$CONFIG_DIR/mise"

# zellij config
create_path "zellij" "$CONFIG_DIR/zellij"
try_link "Zellij" "$LOCAL_PATH/configs/zellij.kdl" "$CONFIG_DIR/zellij/config.kdl"

# Link Wezterm config
try_link "Wezterm" "$LOCAL_PATH/configs/wezterm" "$CONFIG_DIR/wezterm"

# Link Starship config
try_link "Starship" "$LOCAL_PATH/configs/starship.toml" "$CONFIG_DIR/starship.toml"

# Link btop config
create_path "btop" "$CONFIG_DIR/btop"
try_link "Btop++" "$LOCAL_PATH/configs/btop.conf" "$CONFIG_DIR/btop/btop.conf"

# Link opencode config
create_path "opencode" "$CONFIG_DIR/opencode"
create_path "opencode themes" "$CONFIG_DIR/opencode/themes"
try_link "opencode" "$LOCAL_PATH/configs/opencode/opencode.jsonc" "$CONFIG_DIR/opencode/opencode.jsonc"
try_link "opencode tui config" "$LOCAL_PATH/configs/opencode/tui.jsonc" "$CONFIG_DIR/opencode/tui.jsonc"
try_link "opencode kanagawa custom theme" "$LOCAL_PATH/configs/opencode/kanagawa-custom.json" "$CONFIG_DIR/opencode/themes/kanagawa-custom.json"
try_link "opencode AGENTS.md" "$LOCAL_PATH/configs/opencode/AGENTS.md" "$CONFIG_DIR/opencode/themes/AGENTS.md"

# Link bat config
try_link "bat" "$LOCAL_PATH/configs/bat" "$CONFIG_DIR/bat"

# Link IdeaVim config
try_link "IdeaVim" "$LOCAL_PATH/configs/ideavimrc" "$HOME/.ideavimrc"

# Link ripgrep ignore config
try_link "Ripgrep Ignore" "$LOCAL_PATH/configs/ripgrep.ignore" "$CONFIG_DIR/ripgrep.ignore"

# --------------------------------------------------
# MacOS / Linux uniuqe install locations
# --------------------------------------------------

if [[ "$OS" == "Darwin" ]]; then
    # Ghostty
    try_link "Ghostty" "$LOCAL_PATH/configs/ghostty" "$APP_SUPPORT_DIR/com.mitchellh.ghostty"

    # Link k9s config
    create_path "k9s" "$APP_SUPPORT_DIR/k9s"
    try_link "k9s config" "$LOCAL_PATH/configs/k9s/config.yaml" "$APP_SUPPORT_DIR/k9s/config.yaml"
    try_link "k9s skins" "$LOCAL_PATH/configs/k9s/skins" "$APP_SUPPORT_DIR/k9s/skins"

    # Link Lazygit config
    create_path "k9s" "$APP_SUPPORT_DIR/lazygit"
    try_link "Lazygit" "$LOCAL_PATH/configs/lazygit.yml" "$APP_SUPPORT_DIR/lazygit/config.yml"
elif [[ "$OS" == "Linux" ]]; then
    # Link systemd custom services
    try_link "systemd services" "$LOCAL_PATH/configs/systemd" "$CONFIG_DIR/systemd"

    # Ghostty
    try_link "Ghostty" "$LOCAL_PATH/configs/ghostty-linux" "$CONFIG_DIR/ghostty"

    # Link k9s config
    create_path "k9s" "$CONFIG_DIR/k9s"
    try_link "k9s config" "$LOCAL_PATH/configs/k9s/config.yaml" "$CONFIG_DIR/k9s/config.yaml"
    try_link "k9s skins" "$LOCAL_PATH/configs/k9s/skins" "$CONFIG_DIR/k9s/skins"

    # Link Lazygit config
    create_path "k9s" "$CONFIG_DIR/lazygit"
    try_link "Lazygit" "$LOCAL_PATH/configs/lazygit.yml" "$CONFIG_DIR/lazygit/config.yml"

    # Hyprland and hypr configs
    try_link "Hypr config" "$LOCAL_PATH/configs/hypr" "$CONFIG_DIR/hypr"

    # Link custom binaries/scripts
    create_path "~/bin" "$HOME/bin"
    try_link "hyprscope (gamescope/hyprland util)" "$LOCAL_PATH/configs/hypr/scripts/hyprscope/hyprscope.sh" "$HOME/bin/hyprscope"
fi
