{ ... }:
{
  networking.firewall = {
    interfaces.tailscale0 = {
      allowedTCPPorts = [
        53
        80
        443
      ];
      allowedUDPPorts = [ 53 ];
    };
    trustedInterfaces = [ "tailscale0" ];
  };
  services.tailscale = {
    enable = true;
    permitCertUid = "caddy";
  };
}
