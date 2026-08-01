-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Session daemons (awww, cliphist, etc.) are managed by systemd user units
-- under UWSM (WantedBy=graphical-session.target). Prefer those over hl.exec_cmd.
