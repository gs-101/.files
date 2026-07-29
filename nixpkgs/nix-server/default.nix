{
  imports = [
    ../shared/options/boot.nix
    ./options/disko.nix
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
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  networking.hostName = "nix-notebook";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
