{
  config,
  host,
  username,
  ...
}:
{
  services = {
    anki-sync-server = {
      enable = true;
      address = "127.0.0.1";
      users = [
        {
          inherit username;
          passwordFile = config.sops.secrets.anki_sync_server.path;
        }
      ];
    };
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          handle_path /anki-sync-server* {
            reverse_proxy ${config.services.anki-sync-server.address}:${toString config.services.anki-sync-server.port}
          }
        '';
      };
    };
  };
}
