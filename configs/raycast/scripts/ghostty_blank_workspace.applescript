#!/usr/bin/env osascript
# @raycast.schemaVersion 1
# @raycast.title Ghostty: New 2x1 Workspace
# @raycast.mode silent
# @raycast.packageName Ghostty
# @raycast.icon 󰆍
# @raycast.description Creates a new tab in the active Ghostty window (same CWD) and sets up a blank 2x2 grid layout.

tell application "Ghostty"
    activate
    
    -- Get current window/tab/terminal
    set activeWin to front window
    set activeTab to selected tab of activeWin
    set sourceTerm to focused terminal of activeTab
    
    -- Check if the tab already has splits
    set currentTerminals to terminals of activeTab
    if (count of currentTerminals) > 1 then
        display alert "Cannot create worktree layout" message "The current tab already has splits/panes. This script requires a single-pane tab." as warning buttons {"OK"} default button "OK"
        return
    end if
    
    -- Create the split layout in the current tab
    set cfg to new surface configuration
    set topLeft to sourceTerm
    set bottomLeft to split topLeft direction down with configuration cfg
    set topRight to split topLeft direction right with configuration cfg
    
    -- Top left pane
    focus topLeft
end tell
