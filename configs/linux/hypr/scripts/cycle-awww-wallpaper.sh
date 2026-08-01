#!/bin/bash

# Configuration
WALLPAPER_DIR="${1:-$HOME/Pictures/Wallpapers}"
TRANSITION_TYPE="fade"
TRANSITION_DURATION=2
TRANSITION_FPS=160
TRANSITION_STEP=90

# Skip if a fullscreen window (game) is running. Tolerate early/unavailable hyprctl.
if clients_json="$(hyprctl -j clients 2>/dev/null)" && [[ -n "$clients_json" ]]; then
    if echo "$clients_json" | jq -e '.[] | select(.fullscreen == true)' >/dev/null 2>&1; then
        echo "$(date): Fullscreen window detected - skipping"
        exit 0
    fi
fi

# Pick random image
IMAGE=$(fd -t f -e jpg -e jpeg -e png -e webp -e gif . "$WALLPAPER_DIR" 2>/dev/null | shuf -n 1)

if [ -n "$IMAGE" ]; then
    echo "$(date): Setting wallpaper: $IMAGE"
    awww img "$IMAGE" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-fps "$TRANSITION_FPS" \
        --transition-step "$TRANSITION_STEP"
else
    echo "$(date): No images found in $WALLPAPER_DIR"
fi
