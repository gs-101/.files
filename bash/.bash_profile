# Set up Nix profile.
if [ -f /run/current-system/profile/etc/profile.d/nix.sh ]; then
    source /run/current-system/profile/etc/profile.d/nix.sh
fi

# Keep Home Manager out of shell configuration.
if [ -f ~/.nix-profile/bin/home-manager ]; then
    source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
fi
