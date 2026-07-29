{ config, lib, ... }:
{
  services = {
    endlessh-go = {
      enable = true;
      port = 22;
      openFirewall = true;
      prometheus = lib.mkIf config.services.prometheus.enable {
        enable = true;
      };
    };
    openssh.ports = [ 2200 ];
  };
}
