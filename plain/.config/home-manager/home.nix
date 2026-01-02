{ lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    stateVersion = "24.11";

    packages = with pkgs; [
      anki
      hyprlauncher
      television
      wakatime-cli
      wasabiwallet
    ];
  };

  programs = with pkgs; {
    home-manager.enable = true;
  };

  targets.genericLinux.enable = true;
}
