{ lib, pkgs, ... }:

{
  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    stateVersion = "24.11";

    packages = with pkgs; [
      devcontainer
      matugen
      nix-search-tv
      television
      wakatime-cli
    ];
  };

  programs = with pkgs; {
    home-manager.enable = true;
  };

  targets.genericLinux.enable = true;
}
