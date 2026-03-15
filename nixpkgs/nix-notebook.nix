{ config, lib, ... }:
{
  imports = [
    ./base.nix
    ./options/disko/nix-notebook.nix
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
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
  };
  networking.hostName = "nix-notebook";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  services = {
    xserver = {
      enable = true;
      xkb.layout = "br";
    };
  };
  system.stateVersion = "25.11";
  time.timeZone = "America/Sao_Paulo";
}
