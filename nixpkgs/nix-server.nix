{
  config,
  lib,
  ...
}:
{
  imports = [
    ./server.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
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
