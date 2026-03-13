{ pkgs, lib, ... }:
{
  imports = [
    ./options/i18n.nix
    ./options/boot.nix
    ./options/networking.nix
    ./options/services/guix.nix
    ./options/services/pipewire.nix
    ./options/services/xserver.nix
    ./options/virtualisation/podman.nix
  ];
  hardware.bluetooth.enable = true;
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.dconf.enable = true;
  security.rtkit.enable = true;
  services = {
    openssh.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;
  };
  users.users = {
    gabriel = {
      description = "Gabriel Santos";
      extraGroups = [
        "networkmanager"
        "podman"
        "wheel"
      ];
      isNormalUser = true;
      initialPassword = "vm";
    };
  };
  virtualisation.containers.enable = true;
}
