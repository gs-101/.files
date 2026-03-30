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
      interfaces.tailscale0 = {
        allowedTCPPorts = [
          53
          80
          443
        ];
        allowedUDPPorts = [ 53 ];
      };
    };
    hostName = host;
    networkmanager.enable = true;
  };
}
