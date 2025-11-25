#!/bin/bash

# Creates symlinks from repo into their default locations in `~` and `~/.config`.

OS=$(uname)
CONFIG_DIR="$HOME/.config"
APP_SUPPORT_DIR="$HOME/Library/Application Support"
SCRIPT_DIR="$(dirname "$(realpath "$0")")" # path for script directory

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

echo "Linking files from repo at path $SCRIPT_DIR..."
echo

# mise config
try_link "Mise" "$SCRIPT_DIR/configs/mise" "$CONFIG_DIR/mise"

# Link Wezterm config
try_link "Wezterm" "$SCRIPT_DIR/configs/wezterm" "$CONFIG_DIR/wezterm"

# Link Starship config
try_link "Starship" "$SCRIPT_DIR/configs/starship.toml" "$CONFIG_DIR/starship.toml"

# Link Lazygit config
create_path "k9s" "$APP_SUPPORT_DIR/lazygit"
try_link "Lazygit" "$SCRIPT_DIR/configs/lazygit.yml" "$APP_SUPPORT_DIR/lazygit/config.yml"

# Link btop config
create_path "btop" "$CONFIG_DIR/btop"
try_link "Btop++" "$SCRIPT_DIR/configs/btop.conf" "$CONFIG_DIR/btop/btop.conf"

# Link opencode config
create_path "opencode" "$CONFIG_DIR/opencode"
create_path "opencode themes" "$CONFIG_DIR/opencode/themes"
try_link "opencode" "$SCRIPT_DIR/configs/opencode/opencode.jsonc" "$CONFIG_DIR/opencode/opencode.jsonc"
try_link "opencode kanagawa custom theme" "$SCRIPT_DIR/configs/opencode/kanagawa-custom.json" "$CONFIG_DIR/opencode/themes/kanagawa-custom.json"

# Link bat config
try_link "bat" "$SCRIPT_DIR/configs/bat" "$CONFIG_DIR/bat"

# Link Ghostty config
try_link "Ghostty" "$SCRIPT_DIR/configs/ghostty" "$APP_SUPPORT_DIR/com.mitchellh.ghostty"

# Link IdeaVim config
try_link "IdeaVim" "$SCRIPT_DIR/configs/ideavimrc" "$HOME/.ideavimrc"

# Link ripgrep ignore config
try_link "Ripgrep Ignore" "$SCRIPT_DIR/configs/ripgrep.ignore" "$CONFIG_DIR/ripgrep.ignore"

# Link k9s config
if [[ "$OS" == "Darwin" ]]; then
    create_path "k9s" "$APP_SUPPORT_DIR/k9s"
    try_link "k9s config" "$SCRIPT_DIR/configs/k9s/config.yaml" "$APP_SUPPORT_DIR/k9s/config.yaml"
    try_link "k9s skins" "$SCRIPT_DIR/configs/k9s/skins" "$APP_SUPPORT_DIR/k9s/skins"
elif [[ "$OS" == "Linux" ]]; then
    create_path "k9s" "$CONFIG_DIR/k9s"
    try_link "k9s config" "$SCRIPT_DIR/configs/k9s/config.yaml" "$CONFIG_DIR/k9s/config.yaml"
    try_link "k9s skins" "$SCRIPT_DIR/configs/k9s/skins" "$CONFIG_DIR/k9s/skins"
fi
