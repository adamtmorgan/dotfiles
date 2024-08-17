#!/bin/bash

# Creates symlinks from repo into their default locations in `~` and `~/.config`.

CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$(dirname "$(realpath "$0")")" # path for script directory

# Links a source to a destination and handles edge cases
function try_link() {
    configName=$1
    sourcePath=$2
    destinationPath=$3

    if [ ! -f "$sourcePath" ]; then
        echo "Config for $configName not found in repo."
    elif [ ! -e "$destinationPath" ]; then
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

echo "Linking files from repo at path $SCRIPT_DIR..."
echo

# Move Alacritty config
try_link "Alacritty" "$SCRIPT_DIR/configs/alacritty.toml" "$HOME/.alacritty.toml"

# Move Tmux config
try_link "Tmux" "$SCRIPT_DIR/configs/tmux.conf" "$HOME/.tmux.conf"

# Move Starship config
try_link "Starship" "$SCRIPT_DIR/configs/starship.toml" "$CONFIG_DIR/starship.toml"
