{
  config,
  host,
  lib,
  ...
}:
{
  imports = [
    ./base.nix
    ./options/disko/${host}.nix
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
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
  };
  console.keyMap = "br-abnt2";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.hostName = host;
  services.xserver.xkb.layout = "br";
  system.stateVersion = "26.05";
  time.timeZone = "America/Sao_Paulo";
}
