{ ... }:
{
  imports = [
    ./general.nix
    ./options/nix/gc.nix
    ./options/services/endlessh-go.nix
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
  networking = {
    useNetworkd = true;
  };
  systemd = {
    network.networks."10-lan" = {
      matchConfig.Name = "en* eth*";
      networkConfig.DHCP = "yes";
    };
    oomd = {
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
      settings.OOM = {
        DefaultMemoryPressureDurationSec = "30s";
        DefaultMemoryPressureLimit = "70%";
        SwapUsedLimitPercent = "95%";
      };
    };
    services.sshd.serviceConfig.ManagedOOMPreference = "avoid";
  };
  services.pulseaudio.enable = false;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };
}
