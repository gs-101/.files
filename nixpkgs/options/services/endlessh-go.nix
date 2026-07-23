{ config, lib, ... }:
let
  port = 22;
in
{
  imports = [
    ./openssh.nix
  ];
  services = {
    endlessh-go = {
      enable = true;
      inherit port;
      openFirewall = true;
      prometheus = lib.mkIf config.services.prometheus.enable {
        enable = true;
      };
    };
    openssh.ports = [ 2200 ];
  };
}
