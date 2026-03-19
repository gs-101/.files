{ pkgs, ... }:
{
  home.sessionVariables = {
    PAGER = "${pkgs.bat}/bin/bat";
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "base16-256";
    };
  };
}
