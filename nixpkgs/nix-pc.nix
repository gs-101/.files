{ lib, modulesPath, ... }:
{
  imports = [
    ./base.nix
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "floppy"
        "sd_mod"
        "sr_mod"
      ];
      kernelModules = [ ];
    };
    loader.grub = {
      enable = true;
      device = "/dev/sdb";
      useOSProber = true;
    };
  };
  console.keyMap = "br";
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/a5ae5194-4053-4ae6-a9da-6b1a2c911ff6";
      fsType = "ext4";
    };
  };
  networking.hostName = "nix-pc";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  services = {
    xserver = {
      enable = true;
      xkb.layout = "br";
    };
  };
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/22363137-748a-4d77-809c-16ad7eccfbd2";
    }
  ];
  system.stateVersion = "25.11";
  time.timeZone = "America/Sao_Paulo";
}
