{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  skills = pkgs.symlinkJoin {
    name = "skills";
    paths = with pkgs; [
      caveman
    ];
  };
in
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    inherit username;
    file.".agents/skills".source = skills;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      cryptsetup
      gimp
      inkscape
      monero-cli
      ouch
      quickemu
      tor-browser
      viu
      wasabiwallet
      zotero
    ];
    sessionPath = [
      "${config.xdg.configHome}/guix/current/bin"
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    shell.enableBashIntegration = true;
    stateVersion = "25.11";
  };
}
