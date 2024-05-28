#!/bin/bash

# Copies configs from their default locations in `~` and `~/.config` into this repo.

CONFIG_DIR="$HOME/.config"
SCRIPT_DIR="$(dirname "$(realpath "$0")")" # path for script directory
REPO_CONFIGS_DIR="${SCRIPT_DIR}/configs"

# Check that configs directory exists
if [ -e "${REPO_CONFIGS_DIR}" ]; then
    echo "Copying files default destinations to ${REPO_CONFIGS_DIR}..."

    # Copy alacritty.toml to dotfiles repo
    if cp "$HOME/.alacritty.toml" "${REPO_CONFIGS_DIR}/alacritty.toml"; then
        echo "Copied .alacritty.toml to ${REPO_CONFIGS_DIR}"
    else
        echo "Failed to copy .alacritty.toml to ${REPO_CONFIGS_DIR}."
    fi

    # Copy Tmux config to dotfiles repo
    if cp "$HOME/.tmux.conf" "${REPO_CONFIGS_DIR}/tmux.conf"; then
        echo "Copied .tmux.conf to ${REPO_CONFIGS_DIR}"
    else
        echo "Failed to copy .tmux.conf to ${REPO_CONFIGS_DIR}."
    fi

    # Copy Starship config to dotfiles repo
    if cp "${CONFIG_DIR}/starship.toml" "${REPO_CONFIGS_DIR}/starship.toml"; then
        echo "Copied starship.toml to ${REPO_CONFIGS_DIR}"
    else
        echo "Failed to copy starship.toml to ${REPO_CONFIGS_DIR}."
    fi
else
    echo "dotfiles/configs directory not found. Is this bash script located inside of the repo? It should be."
    exit
fi

echo "All configs have been collected and copied into ${REPO_CONFIGS_DIR}."
