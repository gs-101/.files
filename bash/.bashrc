# Define the GPG_TTY as the one being currently used.
# This fixes so many issues that it should be a default.
export GPG_TTY=$(tty)

# gpg-agent frustratingly doesn't seem to update on startup.
# This restarts it so SSH keys can be used.
gpg-connect-agent updatestartuptty /bye >/dev/null

# Save commands in history on a single line.
shopt -s cmdhist
# Do not overwrite history.
shopt -s histappend
# Recursive globbing.
shopt -s globstar

# Enable starship prompt only in graphical environments,
# as I like to hang out in the kernel terminal sometimes.
if [ -n "$DISPLAY" ]; then eval "$(starship init bash)"; fi

# Enable shell integration for television.
eval "$(tv init bash)"
