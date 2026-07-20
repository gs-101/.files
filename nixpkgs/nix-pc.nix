{
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware/nvidia/maxwell.nix
    ./personal.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };
    kernelModules = [ "kvm-intel" ];
  };
  console.keyMap = "br-abnt2";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.xserver.xkb.layout = "br";
  system.stateVersion = "26.05";
  time.timeZone = "America/Sao_Paulo";
}
