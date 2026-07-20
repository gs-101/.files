{ config, ... }:
{
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
      gsp.enable = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.enable = false;
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
