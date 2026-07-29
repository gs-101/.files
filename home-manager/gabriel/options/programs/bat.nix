{ lib, pkgs, ... }:
let
  bat = lib.getExe pkgs.bat;
in
{
  home = {
    sessionVariables.PAGER = "${bat} --paging=always";
    shellAliases.cat = bat;
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "noctalia";
    };
  };
}
