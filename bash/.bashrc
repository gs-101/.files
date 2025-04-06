# Define the GPG_TTY as the one being currently used.
# This fixes so many issues that it should be a default.
export GPG_TTY=$(tty)

# gpg-agent frustratingly doesn't seem to update on startup.
# This restarts it so SSH keys can be used.
gpg-connect-agent updatestartuptty /bye >/dev/null

# Do not overwrite history.
shopt -s histappend
# Recursive globbing.
shopt -s globstar

# Enable shell integration for direnv.
eval "$(direnv hook bash)"

# Enable starship prompt only in graphical environments,
# as I like to hang out in the kernel terminal sometimes.
if [ -n "$DISPLAY" ]; then eval "$(starship init bash)"; fi

# Enable shell integration for television.
eval "$(tv init bash)"

# Enable shell integration for pay-respects.
eval "$(pay-respects bash)"

# Enable shell integration for zoxide.
eval "$(zoxide init bash)"

# I don't use fzf. This replaces zoxide's fzf integration with
# television, my preferred fuzzy finder.
function __zoxide_zi() {
    result="$(zoxide query -l -- "$@" | tv)" && cd "$result"
}

# Disable flow control keybinds (that freeze your terminal).
stty -ixon
