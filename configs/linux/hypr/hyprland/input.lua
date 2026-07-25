---------------
---- INPUT ----
---
---------------

-- Mimics MacOS acceleration curve. Grok-written
-- curve scaler for fine-tuning.

-- Baseline curve (at sensitivity = 1.0)
local baseline_curve = {
    step = 0.1625,
    points = { 0.000, 0.194, 0.388, 0.583, 0.777, 1.046, 1.338, 1.630, 1.922,
        2.214, 2.507, 2.799, 3.091, 3.488, 3.932, 4.375, 4.819, 5.263,
        5.707, 6.150, 6.594, 7.038, 7.481, 7.925, 8.369, 8.812, 9.256,
        9.700, 10.143, 10.587, 11.031, 11.474, 11.918, 12.362, 12.805,
        13.249, 13.693, 14.137, 14.580, 15.497 }
}

local function build_accel_profile(sensitivity)
    sensitivity = sensitivity or 1.0
    local scaled = {}
    for i, v in ipairs(baseline_curve.points) do
        if i == 1 then
            scaled[i] = 0.000 -- always keep 0 at start
        else
            scaled[i] = v * sensitivity
        end
    end

    local str = "custom " .. baseline_curve.step
    for _, v in ipairs(scaled) do
        str = str .. " " .. string.format("%.3f", v)
    end
    return str
end


hl.config({
    input = {
        kb_layout      = "us",
        kb_variant     = "",
        kb_model       = "",
        kb_options     = "ctrl:nocaps",
        kb_rules       = "",

        follow_mouse   = 1,

        sensitivity    = 1,
        accel_profile  = build_accel_profile(0.18),

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
