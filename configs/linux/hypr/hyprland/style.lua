-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 6,
        gaps_out         = 16,

        border_size      = 3,

        col              = {
            -- active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            active_border   = { colors = { "rgba(FFEEC4ee)", "rgba(FFA300ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            -- enabled      = true,
            -- range        = 4,
            -- render_power = 3,
            -- color        = 0xee1a1a1a,

            enabled = true,
            range = 20,
            render_power = 3,
            color = "rgba(00000088)",
            color_inactive = "rgba(00000044)",
            offset = { 0, 1 },
            scale = 1.0,
        },

        blur             = {
            enabled  = true,
            size     = 30,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })
hl.curve("popupWorkspace", { type = "spring", mass = 1, stiffness = 800, dampening = 58})
hl.curve("slideWorkspace", { type = "spring", mass = 2, stiffness = 660, dampening = 64})
hl.curve("windowInOut", { type = "spring", mass = 2, stiffness = 890, dampening = 80})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "windowInOut", style = "popin 20%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, spring = "windowInOut", style = "popin" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.6, spring = "slideWorkspace", style = "slidefade 1%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2, spring = "slideWorkspace", style = "slidefade 1%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2, spring = "slideWorkspace", style = "slidefade 1%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, spring = "popupWorkspace", style = "slidevert 1%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
