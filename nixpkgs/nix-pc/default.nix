{
  imports = [
    ../shared/options/boot.nix
    ./options/disko.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "nouveau"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };
    kernelModules = [ "kvm-intel" ];
  };
  hardware.cpu.intel.updateMicrocode = true;
  networking.hostName = "nix-pc";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";
}
