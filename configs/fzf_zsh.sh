# Custom shell functions for using FZF
# Files are opened using nvim. Dirs are cd'd into.
#
# To use, source this file in your .zshrc file to include it.
#
# Add the following to your .zshrc, only with the path updated
# to this file:
# [ -f ~/fzf_zsh.sh ] && source ~/fzf_zsh.sh
#

export FZF_DEFAULT_OPTS="--bind ctrl-j:down,ctrl-k:up"

# ~/.custom_shell_functions

# Open files using fzf
function fof() {
    local file
    file=$(fzf) && [ -f "$file" ] && nvim "$file"
}

# Jump to a directory using fzf
function fcd() {
    local dir
    dir=$(fd -t d | fzf) && cd "$dir"
}

# Open files or navigate to directories using fzf
function ff() {
    local selection
    selection=$(
        fzf --preview 'bat --color=always {}'
    )

    if [ -d "$selection" ]; then
        cd "$selection"
    elif [ -f "$selection" ]; then
        nvim "$selection"
    else
        echo "Not a valid file or directory"
    fi
}
