{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      extraPackages = [ pkgs.podman-compose ];
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };
}
