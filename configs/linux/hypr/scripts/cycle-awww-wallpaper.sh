#!/bin/bash
set -euo pipefail

WALLPAPER_DIR="${1:-$HOME/Pictures/Wallpapers}"
TRANSITION_TYPE="fade"
TRANSITION_DURATION=2
TRANSITION_FPS=160
TRANSITION_STEP=90

IMAGE=$(fd -t f -e jpg -e jpeg -e png -e webp -e gif . "$WALLPAPER_DIR" 2>/dev/null | shuf -n 1 || true)

if [[ -z "$IMAGE" ]]; then
    echo "No images found in $WALLPAPER_DIR" >&2
    exit 1
fi

echo "Setting wallpaper: $IMAGE"
exec awww img "$IMAGE" \
    --resize stretch \
    --transition-type "$TRANSITION_TYPE" \
    --transition-duration "$TRANSITION_DURATION" \
    --transition-fps "$TRANSITION_FPS" \
    --transition-step "$TRANSITION_STEP"
