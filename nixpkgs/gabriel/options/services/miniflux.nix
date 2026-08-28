{
  config,
  ...
}:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.sops.secrets.miniflux.path;
    config = {
      CLEANUP_ARCHIVE_READ_DAYS = -1;
      CLEANUP_ARCHIVE_UNREAD_DAYS = -1;
      FETCH_ODYSEE_WATCH_TIME = 1;
      FETCH_YOUTUBE_WATCH_TIME = 1;
    };
  };
  sops.secrets.miniflux = { };
}
