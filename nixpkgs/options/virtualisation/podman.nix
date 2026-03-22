{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    podman-compose
    qemu
  ];
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };
}
