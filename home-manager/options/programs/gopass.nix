{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      age
      gopass
      wl-clipboard
    ];
  };
}
