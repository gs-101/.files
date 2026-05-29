{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      age
      gopass-pass
      wl-clipboard
    ];
  };
}
