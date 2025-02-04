{ ... }:
{
  services = {
    xserver = {
      displayManager.startx.enable = true;
      xkb.options = "ctrl:nocaps";
    };
  };
}
