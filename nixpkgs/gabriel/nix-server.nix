{
  imports = [
    ./default.nix
    ./options/zramSwap.nix
    ./options/services/any2nix.nix
    ./options/services/4get.nix
    ./options/services/anki-sync-server.nix
    ./options/services/atuin.nix
    ./options/services/blocky.nix
    ./options/services/btrbk.nix
    ./options/services/cloudflared.nix
    ./options/services/forgejo.nix
    ./options/services/gitea-actions-runner.nix
    ./options/services/miniflux.nix
    ./options/services/navidrome.nix
    ./options/services/postgresql-backup.nix
    ./options/services/redlib.nix
    ./options/services/wakapi.nix
    ./options/services/zipline.nix
  ];
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOdceujA3tBt2vYoZE5py6f+98ZIeUdIVVj4XRwoNEO"
      ];
      hostKeys = [ "/etc/ssh/ssh_initrd_ed25519_key" ];
    };
  };
  networking.useNetworkd = true;
  services = {
    "4get".enable = true;
    any2nix.enable = true;
    redlib.enable = true;
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
