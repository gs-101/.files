{
  imports = [
    ./default.nix
    ./options/zramSwap.nix
    ./options/services/any2nix.nix
    ./options/services/4get.nix
    ./options/services/blocky.nix
    ./options/services/cloudflared.nix
    ./options/services/anki-sync-server.nix
    ./options/services/btrbk.nix
    ./options/services/forgejo.nix
    ./options/services/gitea-actions-runner.nix
    ./options/services/miniflux.nix
    ./options/services/navidrome.nix
    ./options/services/wakapi.nix
    ./options/services/zipline.nix
  ];
  networking.useNetworkd = true;
  services = {
    rsshub.enable = true;
    pulseaudio.enable = false;
    restic.backups.google-drive.pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 6"
    ];
    syncthing.enable = true;
  };
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en* eth*";
    networkConfig.DHCP = "yes";
  };
  time.timeZone = "America/Sao_Paulo";
}
