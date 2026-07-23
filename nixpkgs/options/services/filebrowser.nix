{ config, host, ... }:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          redir /filebrowser /filebrowser/
          handle /filebrowser/* {
            reverse_proxy ${config.services.filebrowser.settings.address}:${toString config.services.filebrowser.settings.port}
          }
        '';
      };
    };
    filebrowser = {
      enable = true;
      settings = {
        baseURL = "/filebrowser";
        disable-exec = false;
        port = 8081;
      };
    };
  };
}
