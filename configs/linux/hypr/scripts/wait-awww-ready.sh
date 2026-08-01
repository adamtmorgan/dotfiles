#!/bin/bash
# Wait until awww-daemon's Wayland socket exists (systemd ExecStartPre helper).

sock="${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY:-wayland-1}-awww-daemon.sock"
for _ in $(seq 1 50); do
    [[ -S "$sock" ]] && exit 0
    sleep 0.1
done

echo "awww socket not ready: $sock" >&2
exit 1
