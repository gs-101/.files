{
  config,
  ...
}:
{
  services = {
    anki-sync-server = {
      enable = true;
      address = "127.0.0.1";
      users = [
        {
          username = "gabriel";
          passwordFile = config.sops.secrets.anki_sync_server.path;
        }
      ];
    };
  };
  sops.secrets.anki_sync_server = { };
}
