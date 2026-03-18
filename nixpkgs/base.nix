{
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
    ./options/services/guix.nix
    ./options/services/pipewire.nix
    ./options/services/xserver.nix
    ./options/virtualisation/podman.nix
  ];
  hardware.bluetooth.enable = true;
  nixpkgs.hostPlatform = system;
  programs = {
    appimage.enable = true;
    dconf.enable = true;
    nano.enable = false;
    nix-ld.enable = true;
  };
  security.rtkit.enable = true;
  services = {
    openssh.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;
    xserver.excludePackages = [ pkgs.xterm ];
  };
  users.users = {
    "${username}" = {
      description = fullName;
      extraGroups = [
        "networkmanager"
        "podman"
        "wheel"
      ];
      initialPassword = "password";
      isNormalUser = true;
    };
  };
  virtualisation.containers.enable = true;
}
