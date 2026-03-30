{ host, ... }:
let
  tailscaleIps = {
    "nix-pc" = "100.110.33.17";
    "nix-notebook" = "100.92.70.97";
  };
  tailscaleIp = tailscaleIps.${host};
in
{
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/home.local/${tailscaleIp}";
      interface = "tailscale0";
    };
  };
}
