{ config, pkgs, ... }:
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    homeDirectory = "/home/gabriel";
    username = "gabriel";
    packages = with pkgs; [

      cryptsetup
      gimp
      gpu-screen-recorder
      inkscape
      monero-cli
      quickemu
      wakatime-cli
      wasabiwallet
      wl-clipboard
      zotero
    ];
    sessionVariables = {
      ANKI_WAYLAND = 1;
      NIXOS_OZONE_WL = 1;
      WAKATIME_HOME = "${config.xdg.dataHome}/wakatime";
    };
    stateVersion = "25.11";
  };
}
