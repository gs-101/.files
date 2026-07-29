{ ... }:
{
  imports = [
    ./options/accounts.nix
    ./options/fonts.nix
    ./options/gtk.nix
    ./options/home.nix
    ./options/nixpkgs.nix
    ./options/sops.nix
    ./options/qt.nix
    ./options/xdg.nix
    ./options/programs/anki.nix
    ./options/programs/bash.nix
    ./options/programs/bat.nix
    ./options/programs/direnv.nix
    ./options/programs/emacs.nix
    ./options/programs/fd.nix
    ./options/programs/gh.nix
    ./options/programs/kitty.nix
    ./options/programs/git.nix
    ./options/programs/gopass.nix
    ./options/programs/msmtp.nix
    ./options/programs/notmuch.nix
    ./options/programs/nvf.nix
    ./options/programs/ripgrep.nix
    ./options/programs/starship.nix
    ./options/programs/wakatime.nix
    ./options/programs/zoxide.nix
  ];
  programs = {
    fzf.enable = true;
    home-manager.enable = true;
    librewolf.enable = true;
    mpv.enable = true;
    mbsync.enable = true;
    msmtp.enable = true;
    nh.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    pay-respects.enable = true;
    prismlauncher.enable = true;
    zed-editor.enable = true;
  };
  services = {
    kdeconnect.enable = true;
    podman.enable = true;
    ssh-agent.enable = true;
    syncthing.enable = true; # TODO: Make this declarative.
  };
}
