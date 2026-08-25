{
  imports = [
    ./options/i18n.nix
    ./options/nix/settings.nix
    ./options/services/openssh.nix
    ./options/services/restic.nix
    ./options/services/tailscale.nix
    ./options/sops.nix
    ./options/users.nix
  ];
  programs = {
    dconf.enable = true;
    nano.enable = false;
    nix-ld.enable = true;
  };
  security.rtkit.enable = true;
}
