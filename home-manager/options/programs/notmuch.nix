{ pkgs, ... }:
{
  programs.notmuch = {
    enable = true;
    hooks.preNew = "${pkgs.isync}/bin/mbsync -a";
  };
}
