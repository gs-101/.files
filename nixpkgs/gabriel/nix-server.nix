{
  imports = [
    ./default.nix
    ./options/zramSwap.nix
    ./options/nix/gc.nix
    ./options/services/blocky.nix
    ./options/services/anki-sync-server.nix
    ./options/services/btrbk.nix
    ./options/services/endlessh-go.nix
    ./options/services/fail2ban.nix
    ./options/services/forgejo.nix
    ./options/services/gitea-actions-runner.nix
    ./options/services/miniflux.nix
    ./options/services/rsshub.nix
    ./options/services/syncthing.nix
    ./options/services/wakapi.nix
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
  services.pulseaudio.enable = false;
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "en* eth*";
    networkConfig.DHCP = "yes";
  };
  time.timeZone = "America/Sao_Paulo";
}
