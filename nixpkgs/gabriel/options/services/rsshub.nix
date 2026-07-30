{ config, ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${config.networking.hostName}.tailbf3a7f.ts.net".extraConfig = ''
        redir /rsshub /rsshub/
        handle_path /rsshub/* {
          reverse_proxy localhost:${toString config.services.rsshub.settings.PORT}
        }
      '';
    };
    rsshub.enable = true;
  };
}
