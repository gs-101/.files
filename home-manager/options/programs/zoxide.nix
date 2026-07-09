{ lib, pkgs, ... }:
{
  home.shellAliases = {
    cd = "z";
  };
  programs.zoxide = {
    enable = true;
  };
}
