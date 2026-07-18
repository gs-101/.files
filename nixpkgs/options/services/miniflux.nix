{
  config,
  host,
  ...
}:
{
  services = {
    caddy = {
      enable = true;
      virtualHosts."${host}.tailbf3a7f.ts.net" = {
        extraConfig = ''
          reverse_proxy /miniflux* localhost:8080
        '';
      };
    };
    miniflux = {
      enable = true;
      adminCredentialsFile = config.sops.secrets.miniflux.path;
      config = {
        BASE_URL = "https://${host}.tailbf3a7f.ts.net/miniflux/";
        CLEANUP_ARCHIVE_READ_DAYS = -1;
        CLEANUP_ARCHIVE_UNREAD_DAYS = -1;
        FETCH_ODYSEE_WATCH_TIME = 1;
        FETCH_YOUTUBE_WATCH_TIME = 1;
      };
    };
  };
}
