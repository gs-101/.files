{ pkgs, ... }:
{
  home.packages = [ pkgs.xwayland-satellite ];
  imports = [
    ./noctalia-shell.nix
  ];
  programs.niri = {
    # TODO: migrate to settings after the include statement is added.
    enable = true;
    package = pkgs.niri-unstable;
  };
  xdg = {
    configFile."niri/config.kdl".text = builtins.readFile ./niri.kdl;
    portal = {
      enable = true;
      configPackages = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "gtk";
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
