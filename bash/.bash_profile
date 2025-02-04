# Set up the system, user profile, and related variables.
# /etc/profile will be sourced by bash automatically
# Set up the home environment profile.
if [ -f ~/.profile ]; then source ~/.profile; fi

# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then source ~/.bashrc; fi
# Set up Guix Home profile
if [ -f ~/.profile ]; then . ~/.profile; fi

# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# Merge search-paths from multiple profiles, the order matters.
eval "$(guix package --search-paths \
-p $HOME/.config/guix/current \
-p $HOME/.guix-home/profile \
-p $HOME/.guix-profile \
-p /run/current-system/profile)"

# Prepend setuid programs.
export PATH=/run/setuid-programs:$PATH

