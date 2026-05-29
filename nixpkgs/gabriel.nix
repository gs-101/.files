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
    ./options/hardware/graphics.nix
    ./options/networking.nix
    ./options/nix.nix
    ./options/sops.nix
    ./options/services/openssh.nix
    ./options/services/pipewire.nix
    ./options/services/tailscale.nix
    ./options/services/xserver.nix
    ./options/virtualisation/podman.nix
  ];
  nixpkgs.hostPlatform = system;
  programs = {
    dconf.enable = true;
    nano.enable = false;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        alsa-lib
        atk
        cairo
        cups
        dbus
        expat
        glib
        gtk3
        libgbm
        libx11
        libxcb
        libxcomposite
        libxdamage
        libxext
        libxfixes
        libxkbcommon
        libxrandr
        nspr
        nss
        pango
      ];
    };
  };
  security.rtkit.enable = true;
  users = {
    mutableUsers = false;
    users = {
      "${username}" = {
        description = fullName;
        extraGroups = [
          "input"
          "networkmanager"
          "podman"
          "wheel"
        ];
        hashedPasswordFile = config.sops.secrets.password.path;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO ${username}"
        ];
      };
    };
  };
  virtualisation.containers.enable = true;
}
