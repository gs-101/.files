{
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      adwaita-icon-theme
      cryptsetup
      gimp
      gpu-screen-recorder
      hicolor-icon-theme
      inkscape
      kdePackages.breeze-icons
      monero-cli
      quickemu
      wasabiwallet
      wl-clipboard
      zotero
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    stateVersion = "25.11";
  };
}
