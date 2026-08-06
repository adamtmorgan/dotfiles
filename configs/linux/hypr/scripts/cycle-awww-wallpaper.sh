#!/bin/bash
set -euo pipefail

CONF="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/wallpaper.conf"

mode=cycle
wallpaper_dir="${HOME}/Pictures/Wallpapers"
static_image=
resize=stretch
TRANSITION_TYPE="fade"
TRANSITION_DURATION=2
TRANSITION_FPS=160
TRANSITION_STEP=90

if [[ -f "$CONF" ]]; then
    # shellcheck disable=SC1090
    source "$CONF"
else
    echo "Missing config: $CONF" >&2
    exit 1
fi

set_image() {
    local image=$1
    if [[ ! -f "$image" ]]; then
        echo "Wallpaper not found: $image" >&2
        exit 1
    fi
    echo "Setting wallpaper: $image"
    awww img "$image" \
        --resize "$resize" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-fps "$TRANSITION_FPS" \
        --transition-step "$TRANSITION_STEP"
}

case "$mode" in
    static)
        if [[ -z "${static_image:-}" ]]; then
            echo "mode=static requires static_image in $CONF" >&2
            exit 1
        fi
        # Stop rotation; re-enabled automatically when mode=cycle is applied
        systemctl --user stop wallpaper-cycle.timer 2>/dev/null || true
        set_image "$static_image"
        ;;
    cycle)
        systemctl --user start wallpaper-cycle.timer 2>/dev/null || true
        image=$(fd -t f -e jpg -e jpeg -e png -e webp -e gif . "$wallpaper_dir" 2>/dev/null | shuf -n 1 || true)
        if [[ -z "$image" ]]; then
            echo "No images found in $wallpaper_dir" >&2
            exit 1
        fi
        set_image "$image"
        ;;
    *)
        echo "Invalid mode='$mode' in $CONF (use cycle or static)" >&2
        exit 1
        ;;
esac
