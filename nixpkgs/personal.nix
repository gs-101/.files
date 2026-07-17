{ pkgs, ... }:
{
  imports = [
    ./general.nix
    ./options/hardware/graphics.nix
    ./options/services/pipewire.nix
    ./options/services/xserver.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking = {
    firewall = rec {
      allowedTCPPortRanges = [
        {
          # For KDE Connect.
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
    networkmanager.enable = true;
  };
}
