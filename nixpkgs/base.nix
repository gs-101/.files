{
  fullName,
  pkgs,
  lib,
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
  networking.networkmanager.enable = true;
  programs.dconf.enable = true;
  programs.nano.enable = false;
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
      isNormalUser = true;
      initialPassword = "password";
    };
  };
  virtualisation.containers.enable = true;
}
