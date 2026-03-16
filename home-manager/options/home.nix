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
      cryptsetup
      gimp
      gpu-screen-recorder
      inkscape
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
