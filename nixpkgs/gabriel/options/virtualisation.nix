{ lib, pkgs, ... }:
{
  environment.sessionVariables = {
    PODMAN_COMPOSE_PROVIDER = lib.getExe pkgs.podman-compose;
    PODMAN_COMPOSE_WARNING_LOGS = "false";
  };
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
    };
  };
}
