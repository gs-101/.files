{ host, ... }:
{
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
    hostName = host;
    networkmanager.enable = true;
  };
}
