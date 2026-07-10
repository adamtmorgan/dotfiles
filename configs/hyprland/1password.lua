-- Auto-start 1Password (silent, background)

-- 1Password rules
hl.window_rule({
    match = {
      class = "1password",           -- confirm exact class with `hyprctl clients`
    },
    float = true,
    center = true,
    size = {"65%", "75%"},         -- comfortable on ultrawide; tweak as needed
    -- move = {x = 0, y = 0},      -- optional extra positioning
})

