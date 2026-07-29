{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb.options = "ctrl:nocaps";
    };
  };
}
