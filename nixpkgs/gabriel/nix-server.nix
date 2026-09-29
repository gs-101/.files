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
    ./options/services/xmrig.nix
    ./options/services/xmrig-proxy.nix
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
    rsshub.enable = true;
    pulseaudio.enable = false;
    restic.backups.google-drive.pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 6"
    ];
    syncthing.enable = true;
    xmrig-proxy = {
      enable = true;
      settings = {
        bind = [
          {
            host = "0.0.0.0";
            port = 3333;
            tls = false;
          }
        ];
        custom-diff = 5000;
        custom-diff-stats = true;
        donate-level = 0;
        mode = "nicehash";
        pools = [
          {
            keepalive = true;
            pass = "homelab";
            tls = true;
            url = "pool.supportxmr.com:443";
            user = "84JwhXmsFsRZpcoaQPcFjm8N7Fw9C71Av1ZHXXR4faDXZT9n4DFUxGeWxLpWKg32xFi7g2dDfQB2pC8PMw6RSjk3CbAHiiy";
          }
        ];
        workers = true;
      };
    };
  };
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en* eth*";
    networkConfig.DHCP = "yes";
  };
}
