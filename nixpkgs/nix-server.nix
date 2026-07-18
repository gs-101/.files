{
  config,
  lib,
  ...
}:
{
  imports = [
    ./server.nix
    ./options/services/anki-sync-server.nix
    ./options/services/adguardhome.nix
    ./options/services/fail2ban.nix
    ./options/services/miniflux.nix
    ./options/services/syncthing.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "e1000e"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };
    kernelModules = [ "kvm-intel" ];
  };
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
  };
  system.stateVersion = "26.05";
  time.timeZone = "America/Sao_Paulo";
}
