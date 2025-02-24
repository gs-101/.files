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

# Enable starship prompt.
eval "$(starship init bash)"
