{ pkgs, ... }:
{
  programs.niri = {
    # TODO: migrate to settings after the include statement is added.
    enable = true;
    package = pkgs.niri-unstable;
  };
  xdg.configFile."niri/config.kdl".text = builtins.readFile ./niri.kdl;
}
