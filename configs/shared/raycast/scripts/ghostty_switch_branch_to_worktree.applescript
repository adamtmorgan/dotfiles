#!/usr/bin/env osascript
# @raycast.schemaVersion 1
# @raycast.title Ghostty: Open Branch in Worktree (in active tab)
# @raycast.mode silent
# @raycast.packageName Ghostty
# @raycast.icon 󰆍
# @raycast.description Switches to (or creates) a Git worktree/branch via Worktrunk and sets up the 3-pane layout with nvim + cursor-agent.
# @raycast.argument1 { "type": "text", "placeholder": "branch-name" }

on run argv
    if (count of argv) = 0 then
        error "Branch name is required"
    end if
    
    set branchName to (item 1 of argv) as text
    
    tell application "Ghostty"
        activate
        
        -- 1. Get current window/tab/terminal
        set activeWin to front window
        set activeTab to selected tab of activeWin
        set sourceTerm to focused terminal of activeTab
        set originalCWD to working directory of sourceTerm
        
        -- NEW: Check if the tab already has splits
        set currentTerminals to terminals of activeTab
        if (count of currentTerminals) > 1 then
            display alert "Cannot create worktree layout" message "The current tab already has splits/panes. This script requires a single-pane tab." as warning buttons {"OK"} default button "OK"
            return
        end if
        
        -- 2. Decide whether to use --create or not
        -- First try without --create (switch to existing). If it fails, fall back to --create.
        try
            input text "wt switch " & quoted form of branchName to sourceTerm
            send key "enter" to sourceTerm
            set usingCreate to false
        on error
            -- If plain switch fails, try creating it
            input text "wt switch --create " & quoted form of branchName to sourceTerm
            send key "enter" to sourceTerm
            set usingCreate to true
        end try
        
        -- 3. Wait until the working directory actually changes (reliable polling)
        set maxWait to 6 -- seconds (slightly increased for safety on create)
        set waitInterval to 0.25
        repeat with i from 1 to (maxWait / waitInterval)
            delay waitInterval
            set worktreePath to working directory of sourceTerm
            if worktreePath is not equal to originalCWD and worktreePath is not "" then
                exit repeat
            end if
        end repeat
        
        -- Safety fallback
        if worktreePath is equal to originalCWD or worktreePath is "" then
            set worktreePath to originalCWD
            log "Warning: Could not detect new worktree path"
        end if
        
        -- 4. Build config with the (new or switched) worktree path
        set cfg to new surface configuration
        set initial working directory of cfg to worktreePath
        
        -- 5. Create the split layout in the current tab
        set topLeft to sourceTerm   -- original pane becomes Neovim
        
        set bottomLeft to split topLeft direction down with configuration cfg
        set topRight to split topLeft direction right with configuration cfg
        -- set bottomRight to split bottomLeft direction right with configuration cfg  -- uncomment for full 2x2
        
        -- 6. Launch tools in the panes
        input text "nvim" to topLeft
        send key "enter" to topLeft
        
        input text "cursor-agent" to topRight
        send key "enter" to topRight
        
        -- Bottom pane stays as a clean shell in the worktree
        
        -- 7. Focus the Neovim pane
        focus topLeft
    end tell
end run
