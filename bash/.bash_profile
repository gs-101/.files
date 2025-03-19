# Set up Nix profile.
source /run/current-system/profile/etc/profile.d/nix.sh

# Keep Home Manager out of shell configuration.
if [ -f ~/.nix-profile/bin/home-manager ]; then source ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi
