{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      age
      gopass
      gopass-hibp
      wl-clipboard
    ];
  };
}
