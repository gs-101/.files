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
      devcontainer
      gimp
      inkscape
      monero-cli
      quickemu
      tor-browser
      wasabiwallet
      zotero
    ];
    sessionPath = [
      "${config.xdg.configHome}/guix/current/bin"
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      WGETRC = "${config.xdg.dataHome}/wget/hosts";
    };
    shell.enableBashIntegration = true;
    stateVersion = "25.11";
  };
}
