{
  imports = [
    ../shared/options/boot.nix
    ./options/disko.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
      ];
    };
    kernelModules = [ "kvm-amd" ];
  };
  console.keyMap = "br-abnt";
  hardware = {
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  networking.hostName = "nix-notebook";
  nixpkgs.hostPlatform = "x86_64-linux";
  services = {
    fwupd.enable = true;
    tuned.enable = true;
    upower.enable = true;
    xserver.xkb.layout = "br";
  };
  system.stateVersion = "25.11";
}
