#!/usr/bin/env bash
set -euo pipefail

UNITS=(
    awww-daemon.service
    awww-ready.path
    wallpaper-cycle.service
    wallpaper-cycle.timer
)

usage() {
    cat <<EOF
Usage: $(basename "$0") <command>

Commands:
  start       Start all wallpaper units
  stop        Stop all wallpaper units
  restart     Restart all wallpaper units
  status      Show status of all units + timer
  enable      Enable all units (persist across logins)
  disable     Disable all units
  reload      daemon-reload + restart everything
  cycle       Force one wallpaper change right now
EOF
    exit 1
}

[[ $# -eq 1 ]] || usage
cmd=$1

case "$cmd" in
    start)
        systemctl --user start "${UNITS[@]}"
        echo "Started."
        ;;
    stop)
        systemctl --user stop "${UNITS[@]}"
        echo "Stopped."
        ;;
    restart)
        systemctl --user restart "${UNITS[@]}"
        echo "Restarted."
        ;;
    status)
        systemctl --user status "${UNITS[@]}" --no-pager -l
        echo
        systemctl --user list-timers --all | grep -E 'wallpaper|NEXT' || true
        ;;
    enable)
        systemctl --user enable "${UNITS[@]}"
        echo "Enabled."
        ;;
    disable)
        systemctl --user disable "${UNITS[@]}"
        echo "Disabled."
        ;;
    reload)
        systemctl --user daemon-reload
        systemctl --user reset-failed "${UNITS[@]}" 2>/dev/null || true
        systemctl --user restart "${UNITS[@]}"
        echo "Reloaded + restarted."
        ;;
    cycle)
        systemctl --user start wallpaper-cycle.service
        echo "Wallpaper cycle triggered."
        ;;
    *)
        usage
        ;;
esac
