# Custom shell functions for using FZF
# Files are opened using nvim. Dirs are cd'd into.
#
# To use, source this file in your .zshrc file to include it.
# Also, ensure that `fd` is installed, as that is what actually will
# do the searching in the file system. FZF will simply rank and sort `fd` results.
#
# Add the following to your .zshrc, only with the path updated
# to this file:
# [ -f ~/fzf_zsh.sh ] && source ~/fzf_zsh.sh
#

# Default fzf config as env var
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#D3CCB4,fg+:#eedba0,bg:-1,bg+:-1
  --color=hl:#80A7E0,hl+:#5fd7ff,info:#afaf87,marker:#9DC472
  --color=prompt:#E2DCC0,spinner:#A289C2,pointer:#A289C2,header:#87afaf
  --color=gutter:-1,border:#D1C79B,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="0"
  --margin="0" --prompt=" " --marker="" --pointer="◆"
  --separator="─" --scrollbar="│" --info="right"'

# Uses fd + fzf to find and open a file
function ff() {
    local selection
    selection=$(fd -t f --exclude .git | fzf --bind "change:reload(fd -t f --exclude .git | grep -i {q})" --preview "bat --style=numbers --color=always {} || cat {}")

    if [[ -f "$selection" ]]; then
        nvim "$selection"
    else
        echo "$selection is not a file"
    fi
}

# Uses fd + fzf to find and change to a directory
function ffd() {
    local selection
    selection=$(fd -t d --exclude .git | fzf --bind "change:reload(fd -t d --exclude .git | grep -i {q})" --preview "ls -la {}")
    if [[ -d "$selection" ]]; then
        cd "$selection"
    else
        echo "$selection is not a directory"
    fi
}
