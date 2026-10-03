{
  lib,
  pkgs,
  ...
}:
{
  home = {
    activation = {
      setBackupExtension = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
        export HOME_MANAGER_BACKUP_EXT="backup"
        export HOME_MANAGER_BACKUP_OVERWRITE="1"
      '';
    };
    homeDirectory = "/home/gabriel";
    packages = with pkgs; [
      cryptsetup
      gimp
      inkscape
      monero-cli
      tor-browser
      wasabiwallet
      zotero
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    username = "gabriel";
    stateVersion = "25.11";
  };
}
