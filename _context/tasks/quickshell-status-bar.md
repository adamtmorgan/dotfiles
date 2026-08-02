# TASK NAME
quickshell-status-bar

## SUMMARY
Add a minimal Quickshell shell that shows a top bar with the current time (`HH:mm`), starts under UWSM via a systemd user unit, gets linked by `disperse.sh`, and can be toggled from Hyprland with `SUPER+B` (plus IPC for future custom actions).

## REQUIREMENTS
- Top status bar displaying current time (`HH:mm`)
- Single monitor only (no `Variants` / multi-screen)
- Autostart via systemd user unit under `graphical-session.target` (UWSM-compatible)
- Link `configs/linux/quickshell` → `~/.config/quickshell` from `disperse.sh`
- Keyboard hook to hide/show the bar; same pattern reusable for custom Quickshell behavior

## FILE TREE:
- `configs/linux/quickshell/shell.qml` — bar + clock + IPC/shortcut hooks
- `configs/linux/systemd/user/quickshell.service` — UWSM-friendly user unit
- `disperse.sh` — link quickshell config + unit; enable/start
- `configs/linux/hypr/hyprland/keybindings.lua` — bar toggle bind
- `_context/tasks/quickshell-status-bar.md` — this task file

## IMPLEMENTATION DETAILS
- Clock: `SystemClock` at minute precision, format `HH:mm`
- Toggle bind: `SUPER + B` → `hl.dsp.global("quickshell:barToggle")`
- Control surface: `GlobalShortcut` + `IpcHandler` target `bar` with `toggle` / `show` / `hide`
- systemd: `WantedBy=graphical-session.target`, `Slice=app-graphical.slice`, `ExecStart=/usr/bin/qs -n`

## TODO LIST NAME
quickshell-status-bar

## TODO
[x] Create `_context/tasks/quickshell-status-bar.md` from this plan
[x] Implement `configs/linux/quickshell/shell.qml` (bar, clock, GlobalShortcut, IpcHandler)
[x] Add `configs/linux/systemd/user/quickshell.service`
[x] Update `disperse.sh` to link quickshell config + service and enable/start the unit
[x] Add `SUPER + B` → `quickshell:barToggle` in `keybindings.lua`
[x] Leave `.qmlls.ini` unchanged (already present, empty)

## MEETING NOTES
- Plan approved; execute mode started.
- Implemented shell.qml, quickshell.service, disperse.sh links/enable, SUPER+B bind.
