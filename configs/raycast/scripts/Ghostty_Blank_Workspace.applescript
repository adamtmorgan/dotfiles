#!/usr/bin/env osascript
# @raycast.schemaVersion 1
# @raycast.title Ghostty: New 2x1 Workspace
# @raycast.mode silent
# @raycast.packageName Ghostty
# @raycast.icon 󰆍
# @raycast.description Creates a new tab in the active Ghostty window (same CWD) and sets up a blank 2x2 grid layout.

tell application "Ghostty"
    activate
    
    -- Get the currently active window and focused terminal (this gives us the source CWD)
    set activeWin to front window
    set activeTab to selected tab of activeWin
    set sourceTerm to focused terminal of activeTab
    
    -- Optional: Capture the current working directory explicitly
    set currentCWD to working directory of sourceTerm
    
    -- Create a configuration that inherits the CWD
    set cfg to new surface configuration
    set initial working directory of cfg to currentCWD
    
    -- 1. Create a new tab (in the same window) with the inherited CWD
    set newTab to new tab in activeWin with configuration cfg
    
    -- 2. Get the initial terminal in the new tab (this will be the top-left pane)
    set topLeft to terminal 1 of newTab   -- or focused terminal of newTab
    
    -- 3. Horizontal split: split the top-left pane downward → creates top row and bottom row
    set bottomLeft to split topLeft direction down with configuration cfg
    
    -- 4. Vertical splits on each row
    set topRight to split topLeft direction right with configuration cfg
    #set bottomRight to split bottomLeft direction right with configuration cfg
    
    -- Optional: Focus the top-left pane and bring Ghostty forward
    focus topLeft
end tell
