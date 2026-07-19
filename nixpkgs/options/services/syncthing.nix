{ config, host, ... }: {
  services = {
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          redir /syncthing /syncthing/
          handle_path /syncthing/* {
            reverse_proxy ${config.services.syncthing.guiAddress} {
              header_up Host localhost
            }
          } 
        '';
      };
    };
    syncthing.enable = true;
  };
}
