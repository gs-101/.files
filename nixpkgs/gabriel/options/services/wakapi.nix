{ config, ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${config.networking.hostName}.tailbf3a7f.ts.net".extraConfig = ''
        redir /wakapi /wakapi/
        handle_path /wakapi/* {
          reverse_proxy localhost:${toString config.services.wakapi.settings.server.port}
        }
      '';
    };
    wakapi = {
      enable = true;
      settings = {
        security = {
          allow_signup = false;
        };
        server = {
          base_path = "/wakapi";
          port = 3000;
          public_url = "https://${config.networking.hostName}.tailbf3a7f.ts.net/wakapi/";
        };
      };
    };
  };
}
