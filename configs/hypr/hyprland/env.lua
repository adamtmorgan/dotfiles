-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("STEAM_FORCE_DESKTOPUI_SCALING", "1.25")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GDK_SCALE", "1.33")
hl.env("QT_SCALE_FACTOR", "1.33")

-- Add user/bin to path
hl.env("PATH", os.getenv("HOME") .. "/bin:" .. os.getenv("PATH"))
