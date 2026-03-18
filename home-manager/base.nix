{ ... }:
{
  imports = [
    ./options/fonts.nix
    ./options/gtk.nix
    ./options/home.nix
    ./options/nixpkgs.nix
    ./options/qt.nix
    ./options/xdg.nix
    ./options/programs/alacritty.nix
    ./options/programs/anki.nix
    ./options/programs/bash.nix
    ./options/programs/bat.nix
    ./options/programs/direnv.nix
    ./options/programs/emacs.nix
    ./options/programs/fd.nix
    ./options/programs/gh.nix
    ./options/programs/gpg.nix
    ./options/programs/msmtp.nix
    ./options/programs/noctalia-shell.nix
    ./options/programs/notmuch.nix
    ./options/programs/nvf.nix
    ./options/programs/password-store.nix
    ./options/programs/ripgrep.nix
    ./options/programs/television.nix
    ./options/programs/starship.nix
    ./options/programs/wakatime.nix
    ./options/services/gpg-agent.nix
  ];
  programs = {
    home-manager.enable = true;
    librewolf.enable = true;
    keepassxc.enable = true;
    mpv.enable = true;
    mbsync.enable = true;
    nh.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    pay-respects.enable = true;
  };
  services = {
    kdeconnect.enable = true;
    podman.enable = true;
    syncthing.enable = true;
  };
}
