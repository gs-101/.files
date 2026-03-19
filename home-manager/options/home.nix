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
      tor-browser
      wasabiwallet
      wl-clipboard
      zotero
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      WGETRC = "${config.xdg.dataHome}/wget/hosts";
    };
    shell.enableBashIntegration = true;
    stateVersion = "25.11";
  };
}
