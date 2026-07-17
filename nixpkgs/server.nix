{ ... }:
{
  imports = [
    ./general.nix
    ./options/nix/gc.nix
  ];
  networking = {
    useNetworkd = true;
  };
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en* eth*";
    networkConfig.DHCP = "yes";
  };
  services.pulseaudio.enable = false;
}
