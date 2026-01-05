{ lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    stateVersion = "24.11";

    sessionVariables = {
      ANKI_WAYLAND = 1;
    };

    packages = with pkgs; [
      anki-bin
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
