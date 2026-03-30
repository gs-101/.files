{
  config,
  fullName,
  lib,
  pkgs,
  system,
  username,
  ...
}:
{
  imports = [
    ./options/i18n.nix
    ./options/boot.nix
    ./options/networking.nix
    ./options/nix.nix
    ./options/sops.nix
    ./options/services/guix.nix
    ./options/services/pipewire.nix
    ./options/services/xserver.nix
    ./options/virtualisation/podman.nix
  ];
  nixpkgs.hostPlatform = system;
  programs = {
    appimage.enable = true;
    dconf.enable = true;
    nano.enable = false;
    nix-ld.enable = true;
  };
  security.rtkit.enable = true;
  services.openssh.enable = true;
  users = {
    mutableUsers = false;
    users = {
      "${username}" = {
        description = fullName;
        extraGroups = [
          "networkmanager"
          "podman"
          "wheel"
        ];
        hashedPasswordFile = config.sops.secrets.password.path;
        isNormalUser = true;
      };
    };
  };
  virtualisation.containers.enable = true;
}
