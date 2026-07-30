{
  config,
  ...
}:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${config.networking.hostName}.tailbf3a7f.ts.net".extraConfig = ''
        redir /miniflux /miniflux/
        reverse_proxy /miniflux/* ${config.services.miniflux.config.LISTEN_ADDR}
      '';
    };
    miniflux = {
      enable = true;
      adminCredentialsFile = config.sops.secrets.miniflux.path;
      config = {
        BASE_URL = "https://${config.networking.hostName}.tailbf3a7f.ts.net/miniflux/";
        CLEANUP_ARCHIVE_READ_DAYS = -1;
        CLEANUP_ARCHIVE_UNREAD_DAYS = -1;
        FETCH_ODYSEE_WATCH_TIME = 1;
        FETCH_YOUTUBE_WATCH_TIME = 1;
      };
    };
  };
  sops.secrets.miniflux = { };
}
