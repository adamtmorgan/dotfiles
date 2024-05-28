#!/bin/bash

# Copies configs from repo into their default locations in `~` and `~/.config`.

CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$(dirname "$(realpath "$0")")" # path for script directory

echo "Copying files from repo at path ${SCRIPT_DIR}"

# Move Alacritty config
if cp "${SCRIPT_DIR}/configs/alacritty.toml" "$HOME/.alacritty.toml"; then
    echo "Copied .alacritty.toml to $HOME"
else
    echo "Failed to copy .alacritty.toml to $HOME. Make sure the migrate.sh file is in the root of the dotfiles repo."
fi

# Move Tmux config
if cp "${SCRIPT_DIR}/configs/tmux.conf" "$HOME/.tmux.conf"; then
    echo "Copied .tmux.conf to $HOME"
else
    echo "Failed to copy .tmux.conf to $HOME. Make sure the migrate.sh file is in the root of the dotfiles repo."
fi

# Move Starship config
if cp "${SCRIPT_DIR}/configs/starship.toml" "${CONFIG_DIR}/starship.toml"; then
    echo "Copied starship.toml to ${CONFIG_DIR}"
else
    echo "Failed to copy starship.toml to ${CONFIG_DIR}. Make sure the migrate.sh file is in the root of the dotfiles repo."
fi

echo "All configs have been moved."
