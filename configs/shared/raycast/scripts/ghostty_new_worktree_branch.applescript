#!/usr/bin/env osascript
# @raycast.schemaVersion 1
# @raycast.title Ghostty: New Worktree (in active tab)
# @raycast.mode silent
# @raycast.packageName Ghostty
# @raycast.icon 󰆍
# @raycast.description Creates a new Git worktree/branch via Worktrunk, sets up splits in the current tab, and launches common tools.
# @raycast.argument1 { "type": "text", "placeholder": "new-branch-name" }

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
            display alert "Cannot create worktree layout" message "The current tab already has splits/panes. This script requires a single-pane tab to set up the 3-pane layout correctly." as warning buttons {"OK"} default button "OK"
            return
        end if
        
        -- 2. Run Worktrunk in the current terminal so the real `cd` happens
        input text "wt switch --create " & quoted form of branchName to sourceTerm
        send key "enter" to sourceTerm
        
        -- Wait until the working directory actually updates (more reliable than fixed delay)
        set maxWait to 5 -- seconds
        set waitInterval to 0.2
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
            log "Warning: Could not detect new worktree path, falling back to original"
        end if
        
        -- 3. Build config with the new worktree path
        set cfg to new surface configuration
        set initial working directory of cfg to worktreePath
        
        -- 4. Create the split layout in the *current* tab
        -- topLeft is the original pane (we'll turn it into Neovim)
        set topLeft to sourceTerm   -- main pane (will become Neovim)
        
        set bottomLeft to split topLeft direction down with configuration cfg
        set topRight to split topLeft direction right with configuration cfg
        
        -- 5. Launch tools in the panes
        input text "nvim" to topLeft
        send key "enter" to topLeft
        
        input text "cursor-agent" to topRight
        send key "enter" to topRight
        
        -- Bottom panes (and any uncommented bottomRight) remain as clean shells in the new worktree
        
        -- 6. Focus the Neovim pane
        focus topLeft
    end tell
end run
