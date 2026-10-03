{
  lib,
  pkgs,
  ...
}:
let
  skills = pkgs.symlinkJoin {
    name = "agent-skills";
    paths = [
      (pkgs.linkFarm "caveman-skill" {
        caveman = pkgs.caveman;
      })
      pkgs.emacs-skills
    ];
  };
in
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    activation = {
      setBackupExtension = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
        export HOME_MANAGER_BACKUP_EXT="backup"
        export HOME_MANAGER_BACKUP_OVERWRITE="1"
      '';
    };
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
    file = {
      ".agents/skills".source = skills;
      ".gemini/skills".source = skills;
    };
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    username = "gabriel";
    stateVersion = "25.11";
  };
}
