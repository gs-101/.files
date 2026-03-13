{ config, pkgs, ... }:
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    homeDirectory = "/home/gabriel";
    username = "gabriel";
    packages = with pkgs; [
      aporetic
      cascadia-code
      cryptsetup
      gimp
      glib
      gpu-screen-recorder
      gsettings-desktop-schemas
      inkscape
      monero-cli
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      television
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
