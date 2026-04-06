{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  caveman = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "caveman";
    version = "1.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "JuliusBrussee";
      repo = "caveman";
      tag = "v${finalAttrs.version}";
      hash = "sha256-TYDx7QMgSVczVqNIzVHhctmD4mJWn9UE2MWchRhX77Q=";
    };

    installPhase = ''
      runHook preInstall

      install -Dm444 $src/skills/caveman/SKILL.md $out/caveman/SKILL.md

      runHook postInstall
    '';
  });
  skills = pkgs.symlinkJoin {
    name = "skills";
    paths = [
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
