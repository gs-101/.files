# Merge search-paths from multiple profiles, the order matters.
eval "$(guix package --search-paths \
    -p $HOME/.config/guix/current \
    -p $HOME/.guix-home/profile \
    -p $HOME/.guix-profile \
    -p /run/current-system/profile)"

# Prepend setuid programs.
export PATH=/run/setuid-programs:$PATH

# Set up Nix profile.
source /run/current-system/profile/etc/profile.d/nix.sh

# Keep Home Manager out of shell configuration.
if [ -f ~/.nix-profile/bin/home-manager ]; then source ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi
