{
  pkgs,
  ...
}:
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    username = "gabriel";
    homeDirectory = "/home/gabriel";
    packages = with pkgs; [
      ast-grep
      cryptsetup
      gimp
      inkscape
      monero-cli
      pastel
      quickemu
      tor-browser
      viu
      wasabiwallet
      zotero
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    stateVersion = "25.11";
  };
}
