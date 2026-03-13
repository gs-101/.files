{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./options/accounts.nix
    ./options/fonts.nix
    ./options/gtk.nix
    ./options/home.nix
    ./options/nixpkgs.nix
    ./options/qt.nix
    ./options/xdg.nix
    ./options/programs/alacritty.nix
    ./options/programs/bash.nix
    ./options/programs/bat.nix
    ./options/programs/direnv.nix
    ./options/programs/emacs.nix
    ./options/programs/fd.nix
    ./options/programs/gh.nix
    ./options/programs/git.nix
    ./options/programs/gpg.nix
    ./options/programs/msmtp.nix
    ./options/programs/noctalia-shell.nix
    ./options/programs/password-store.nix
    ./options/programs/pay-respects.nix
    ./options/programs/ripgrep.nix
    ./options/programs/television.nix
    ./options/programs/starship.nix
    ./options/services/gpg-agent.nix
  ];
  programs = {
    anki.enable = true;
    home-manager.enable = true;
    librewolf.enable = true;
    keepassxc.enable = true;
    mpv.enable = true;
    mbsync.enable = true;
    neovim.enable = true;
    nh.enable = true;
    notmuch.enable = true;
  };
  services = {
    kdeconnect.enable = true;
    podman.enable = true;
    syncthing.enable = true;
  };
}
