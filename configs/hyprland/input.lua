---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "ctrl:nocaps",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = -1, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "adaptive",
        --accel_profile = "custom 0 0.1 0.5 1",

        -- Mimic MacOS
        natural_scroll = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
