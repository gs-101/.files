{ pkgs, ... }:
{
  services = {
    xserver = {
      displayManager.startx.enable = true;
      excludePackages = [ pkgs.xterm ];
      xkb.options = "ctrl:nocaps";
    };
  };
}
