{ lib, pkgs, ... }:
{
  programs.notmuch = {
    enable = true;
    hooks.preNew = "${lib.getExe pkgs.isync} -a";
  };
}
